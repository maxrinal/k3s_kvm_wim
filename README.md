# K3S ANSIBLE-KVM

Ingresar al directorio terraform_kvm/terraform_os definir variables de entorno

```bash
terraform init
terraform plan -out="plan"
terraform apply plan

#instead of plan
terraform apply -auto-approve
```

Borrar plataforma
```bash
# terraform destroy -auto-approve
```

Pingear los host previo a la ejecucion de ansible

```bash
#BINARY -m ${MODULE_NAME}  -i ${INVENTORY_FILE} ${PATTERN}
ansible -m ping --inventory ../tmp/hosts.yml all
ansible -m ping -i ../tmp/hosts.yml all

ansible all -m ping --inventory ../tmp/hosts.yml
ansible all -m ping -i ../tmp/hosts.yml
```


# REFERENCES

[k3s ansible](https://github.com/k3s-io/k3s-ansible)

[k3s server config options](https://rancher.com/docs/k3s/latest/en/installation/install-options/server-config/)

[k3s agent config options](https://rancher.com/docs/k3s/latest/en/installation/install-options/agent-config/)

[k3s storage options](https://rancher.com/docs/k3s/latest/en/storage/)

# Static Pod Manifest

Auto provisioning k3s cluster using manifest directory.

`/etc/kubernetes/manifests --> /var/lib/rancher/k3s/server/manifests`

[k3s manifest directoy](https://rancher.com/docs/k3s/latest/en/helm/)

[kubeadm well known paths](https://kubernetes.io/docs/reference/setup-tools/kubeadm/implementation-details/#constants-and-well-known-values-and-paths)


