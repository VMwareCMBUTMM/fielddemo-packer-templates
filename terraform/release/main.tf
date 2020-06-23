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
  name = "Production"
}

data "vra_image" "packer_images" {
  for_each = toset(var.images)

  filter = "name eq '${each.value}'"
}

resource "vra_image_profile" "packer_image_profiles" {
  name        = "packer-image-profile"
  region_id   = data.vra_region.this.id

  dynamic "image_mapping" {
    for_each = data.vra_image.packer_images

    content {
      name       = "[Packer] ${trimprefix(trimsuffix(image_mapping.value.name, "-${var.buildtime}"), "packer-")}"
      image_id   = image_mapping.value.id
    }
  }
}
