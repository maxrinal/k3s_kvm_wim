# Global variables
variable "nombre" { default = "k3s" }

variable "user_name" { default = "vmadmin" }
variable "user_pass" { default = "Test123456" }

variable "os_image_source" { default = "/home/repo/images/debian-11-generic-amd64-20211011-792.qcow2" }

# Auto execute ansible k3s-deploy
variable "EXECUTE_ANSIBLE" {default = true}

# Master Variables
variable "master_count" { default = 1 }
variable "master_cpu" { default = 2 }
variable "master_memory_mb" { default = 2048 }
variable "master_os_path" { default = "/home/repo/images/debian-11-generic-amd64-20211011-792.qcow2" }
variable "master_network" { default = ["default"] }
variable "master_disk_size" { default = 10 * 1024 }

# Worker variables
variable "worker_count" { default = 1 }
variable "worker_cpu" { default = 2 }
variable "worker_memory_mb" { default = 2048 }
variable "worker_os_path" { default = "/home/repo/images/debian-11-generic-amd64-20211011-792.qcow2" }
variable "worker_network" { default = ["default"] }
variable "worker_disk_size" { default = 10 * 1024 }


variable "ansible_extra_vars" {
  default = <<EOF
# Available versions in https://github.com/k3s-io/k3s/releases/
k3s_version=v1.22.4+k3s1
systemd_dir=/etc/systemd/system
extra_server_args="--disable servicelb,traefik,metrics-server"
extra_agent_args=""
EOF
  type    = string
}