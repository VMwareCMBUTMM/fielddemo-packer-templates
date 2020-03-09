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


resource "vra_image_profile" "packer-test" {
  name        = "packer-test-profile"
  description = "Packer Test Image Profile"
  region_id   = data.vra_region.this.id

  image_mapping {
    name       = "CentOS7"
    image_name = "packer-centos7-template"
  }
}

# resource "vra_deployment" "this" {
#   name        = "packer-test-deployment"
#   description = "Deployment to test packer build"
#   project_id  = data.vra_project.this.id
# }


# resource "vra_machine" "this" {
#   name          = "packer-centos-test"
#   description   = "Automated test of the Packer CentOS7 Build"
#   project_id    = data.vra_project.this.id
#   image         = "packer-centos7-template"
#   flavor        = "small"
#   deployment_id = vra_deployment.this.id


#   constraints {
#     mandatory  = true
#     expression = "cloud:vsphere"
#   }
# }