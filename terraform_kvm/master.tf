module "master_cloud_init" {
  count = var.master_count

  # source = "/home/repo/tf_modules/cloud_init"
  source = "git::https://github.com/maxrinal/tf_modules.git//cloud_init"
  

  nombre = "${var.nombre}-master-${count.index}"

  # search_domain         = "ingress.lab.home"
  search_domain         = "virsh.${terraform.workspace}.test"
  user_name             = var.user_name
  user_default_password = var.user_pass

}


module "master_nodes" {
  # source = "/home/repo/tf_modules/kvm_complex_instance"
  source = "git::https://github.com/maxrinal/tf_modules.git//kvm_complex_instance"

  depends_on = [
    module.master_cloud_init
  ]

  # -- # Para crear multiples instancias
  count  = var.master_count
  nombre = "${var.nombre}-master-${count.index}"

  cloud_init_data = module.master_cloud_init[count.index].out_rendered

  assigned_cpu       = var.master_cpu
  assigned_memory_mb = var.master_memory_mb

  network_name_list       = var.master_network
  network_wait_dhcp_lease = true


  os_base_path    = var.master_os_path
  os_disk_size_mb = var.master_disk_size
  # disk_list             = { "docker" : 1024, "data" : 512 }
}

