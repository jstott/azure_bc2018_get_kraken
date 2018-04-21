#
environment = "QA"

# Overall VNet CIDR range and ranges for all subnets
dns_servers = ""

vnet_cidr = "10.94.8.0/23" # 512 hosts: 10.92.8.0 -> 10.92.9.255

# Enough for demo VM's - fyi - can't use all ips in subnet
subnet_cidrs = {
  "Build" = "10.94.8.128/26"
}

lamp_private_ip_address = ["10.94.8.132","10.94.8.133"]

## VM / Ubuntue
# Standard_DS2_v2 = 2cpu, 7G, 14G SSD
vm_size = "Standard_E2s_v3"


# The below default tags will be applied to all resources and are based on the tagging schema.
# See https://docs.google.com/document/d/1PV1ulDUhF0l-3fbK0KLLSqPI7xh325Z5RmgIETsJo_w/edit#heading=h.lb7fhb6njibj for more information
default_tags = {
  ApplicationName   = "TerraformDemo-01"
  Proejct           = "Azure Bootcamp 2018"
  TechnicalResource = "jwstott@gmail.com"
  BusinessOwner     = "jim.stott@oriontech.com"
}
