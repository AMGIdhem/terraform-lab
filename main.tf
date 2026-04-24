provider "oci" {
  config_file_profile = "DEFAULT"
}

module "network" {
  source           = "./modules/network"
  compartment_ocid = var.compartment_ocid
  cidr             = "10.0.0.0/16"
  name             = "dev-vcn"
}

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

data "oci_core_images" "ol" {
  compartment_id = var.compartment_ocid
  operating_system = "Oracle Linux"
  sort_by          = "TIMECREATED"
  sort_order       = "DESC"
}

resource "oci_core_instance" "vm" {
  compartment_id      = var.compartment_ocid
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name

  display_name = "dev-nm"

  shape = "VM.Standard.E2.1.Micro"

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ol.images[0].id
  }

  create_vnic_details {
    subnet_id        = module.network.subnet_id
    assign_public_ip = true
  }

  metadata = {
    ssh_authorized_keys = file("/home/amgidhem/.ssh/oci_terraform_lab.pub")

    user_data = base64encode(<<-EOF
    #cloud-config
    runcmd:
      - yum install -y nginx
      - systemctl enable nginx
      - systemctl start nginx
      - echo "NGINX is running on OCI VM" > /usr/share/nginx/html/index.html
      - firewall-cmd --permanent --add-service=http
      - firewall-cmd --reload
    EOF
  )
  }
}
