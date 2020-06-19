terraform {
  required_providers {
    vra = ">= 0.2.3"
  }
}

provider vra {
  url           = var.vra_url
  refresh_token = var.vra_refresh_token
  insecure      = true
}

data "vra_cloud_account_vsphere" "this" {
  name = "sc2vc03.cmbu.local"
}

data "vra_region" "this" {
  cloud_account_id = data.vra_cloud_account_vsphere.this.id
  region           = data.vra_cloud_account_vsphere.this.enabled_region_ids[0]
}

data "vra_project" "this" {
  name = "Development"
}

resource "vra_deployment" "this" {
  name        = "packer-test-deployment"
  description = "Deployment to test packer build"
  project_id  = data.vra_project.this.id
}

resource "vra_machine" "this" {
  for_each = toset(var.images)

  name          = "${each.value}-test"
  description   = "Automated test of the ${each.value} Build"
  project_id    = data.vra_project.this.id
  image         = "[Packer] ${each.value}"
  flavor        = "small"
  deployment_id = vra_deployment.this.id


  constraints {
    mandatory  = true
    expression = "cloud:vsphere"
  }
}

output "vmIps" {
  value = {for machine in vra_machine.this : machine.name => machine.address}
}