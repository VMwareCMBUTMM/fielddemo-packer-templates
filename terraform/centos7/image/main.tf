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

data "vra_image" "centos7" {
  filter = "name eq 'packer-centos7-template'"
}

resource "vra_image_profile" "packer-test" {
  name        = "packer-test-profile"
  description = "Packer Test Image Profile"
  region_id   = data.vra_region.this.id

  image_mapping {
    name       = "[Packer] CentOS7"
    image_id = data.vra_image.centos7.id
  }
}
