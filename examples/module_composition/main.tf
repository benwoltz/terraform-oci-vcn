# Copyright (c) 2019, 2021, Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# Version requirements

terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = ">=4.41.0"
    }
  }
  required_version = ">= 1.0.0"
}

# Resources

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "3.1.0"

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix
  freeform_tags  = var.freeform_tags
  defined_tags = var.defined_tags

  # vcn parameters
  create_drg               = var.create_drg               # boolean: true or false
  create_internet_gateway  = var.create_internet_gateway  # boolean: true or false
  lockdown_default_seclist = var.lockdown_default_seclist # boolean: true or false
  create_nat_gateway       = var.create_nat_gateway       # boolean: true or false
  create_service_gateway   = var.create_service_gateway   # boolean: true or false
  enable_ipv6              = var.enable_ipv6
  vcn_cidrs                = var.vcn_cidrs # List of IPv4 CIDRs
  vcn_dns_label            = var.vcn_dns_label
  vcn_name                 = var.vcn_name

  # gateways parameters
  drg_display_name              = var.drg_display_name
  internet_gateway_display_name = var.internet_gateway_display_name
  nat_gateway_display_name      = var.nat_gateway_display_name
  service_gateway_display_name  = var.service_gateway_display_name
}

# Outputs

output "module_vcn_ids" {
  description = "vcn and gateways information"
  value = {
    drg_id                       = module.vcn.drg_id
    internet_gateway_id          = module.vcn.internet_gateway_id
    internet_gateway_route_id    = module.vcn.ig_route_id
    nat_gateway_id               = module.vcn.nat_gateway_id
    nat_gateway_route_id         = module.vcn.nat_route_id
    service_gateway_id           = module.vcn.service_gateway_id
    vcn_dns_label                = module.vcn.vcn_all_attributes.dns_label
    vcn_default_security_list_id = module.vcn.vcn_all_attributes.default_security_list_id
    vcn_default_route_table_id   = module.vcn.vcn_all_attributes.default_route_table_id
    vcn_default_dhcp_options_id  = module.vcn.vcn_all_attributes.default_dhcp_options_id
    vcn_id                       = module.vcn.vcn_id
  }
}

# output "module_vcn_all_attributes" {
#   description = "all attributes for each resources created by this example"
#   value = {
#     drg              = module.vcn.drg_all_attributes
#     drg_attachment   = module.vcn.drg_attachment_all_attributes
#     internet_gateway = module.vcn.internet_gateway_all_attributes
#     ig_route_table   = module.vcn.ig_route_all_attributes
#     nat_gateway      = module.vcn.nat_gateway_all_attributes
#     nat_route_table  = module.vcn.nat_route_all_attributes
#     service_gateway  = module.vcn.service_gateway_all_attributes
#     vcn              = module.vcn.vcn_all_attributes
#   }
# }
