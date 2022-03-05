provider "docker" {
  host = "unix:///var/run/docker.sock"
}


terraform {
  required_providers {
    docker =  {
      source = "kreuzwerker/docker"
    }
  }

}

resource "random_password" "random_pass" {
  length = 12
}

variable "container_name" {

}

resource "docker_container" "mysql_container" {
  name = var.container_name
  image = "mysql:latest"
  must_run = true
  start = true
  env = [
    "MYSQL_ROOT_PASSWORD=${random_password.random_pass.result}" 
  ]
  ports { internal = 3306 }
}


output "container_name" {
  value = docker_container.mysql_container.name
}

output "container_ip" {
  value = docker_container.mysql_container.ip_address
}

output "container_port" {
  value = docker_container.mysql_container.ports
}

output "image_name" {
  value = docker_container.mysql_container.image
}


