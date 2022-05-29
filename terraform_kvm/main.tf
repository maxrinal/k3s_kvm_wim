### - ##Creacion de inventario para ansible
resource "local_file" "inventory_ansible" {
  depends_on = [
    module.master_nodes,
    module.worker_nodes,
  ]
  content = templatefile("../templates/inventory.tmpl",
    {
      hosts_user         = var.user_name
      master_list        = module.master_nodes.*.clean_out
      worker_list        = module.worker_nodes.*.clean_out
      tf_workspace       = terraform.workspace
      ansible_extra_vars = var.ansible_extra_vars
    }
  )
  filename = "../tmp/${terraform.workspace}/hosts.yml"
}



# Se requiere instalar rsync en el server de forma previa, se requiere reinciar k3s o buscar alguna alternativa para que ejecute los manifest
# Los archivos del diretorio manifest deben respetar la misma convencion de nombres que los objetos de kuberentes

resource "null_resource" "excute_ansible_k3s" {
  count  = (var.EXECUTE_ANSIBLE == true ? 1:0)

  depends_on = [
    local_file.inventory_ansible
  ]
  provisioner "local-exec" {
    command = <<-EOT
    ANSIBLE_FORCE_COLOR=1 ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ../ansible-k3s-deploy/site.yml -i ../tmp/${terraform.workspace}/hosts.yml
    scp -o StrictHostKeyChecking=no ${var.user_name}@${module.master_nodes[0].ipv4_addressess[0]}:~/.kube/config ../tmp/${terraform.workspace}/kubeconfig

    # Cluster auto configuration copying manifests to /var/lib/rancher/k3s/server/manifests
    # ssh -o StrictHostKeyChecking=no vmadmin@${module.master_nodes[0].ipv4_addressess[0]} sudo apt-get update
    # ssh -o StrictHostKeyChecking=no vmadmin@${module.master_nodes[0].ipv4_addressess[0]} sudo apt-get install -y rsync
    # rsync -a --chown=root:root --chmod=0700 --rsync-path="sudo rsync" ../manifests/ ${var.user_name}@${module.master_nodes[0].ipv4_addressess[0]}:/var/lib/rancher/k3s/server/manifests
EOT

  }
}

output "ssh_conn" {

  value = <<EOT
ssh -o StrictHostKeyChecking=no vmadmin@${module.master_nodes[0].ipv4_addressess[0]}

EOT

}

output "entorno_workspace" {
  value = terraform.workspace
}