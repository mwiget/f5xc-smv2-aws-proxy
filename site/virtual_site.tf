resource "restapi_object" "virtual_site" {
  id_attribute  = "metadata/name"
  path          = "/config/namespaces/shared/virtual_sites"
  # var.master_node_count == 1 ? jsonencode
  data          = jsonencode({
    "metadata": {
      "name": var.f5xc_vsite_name,
      "namespace": "shared",
      "disable": false
    },
    "spec": {
      "site_selector": {
        "expressions": ["virtual_site == ${var.f5xc_vsite_name}"]
      },
      "site_type": "CUSTOMER_EDGE"
    }
  })
}

output "virtual_site" {
  value = restapi_object.virtual_site
}
