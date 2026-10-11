resource "oci_database_tools_database_tools_connection" "database_tools_database_tools_connections" {
  for_each = var.database_tools_database_tools_connections

  compartment_id      = each.value.compartment_id
  display_name        = each.value.display_name
  type                = each.value.type
  advanced_properties = each.value.advanced_properties
  authentication_type = each.value.authentication_type
  connection_string   = each.value.connection_string
  defined_tags        = each.value.defined_tags
  freeform_tags       = each.value.freeform_tags
  private_endpoint_id = each.value.private_endpoint_id
  runtime_identity    = each.value.runtime_identity
  runtime_support     = each.value.runtime_support
  url                 = each.value.url
  user_name           = each.value.user_name

  dynamic "key_stores" {
    for_each = each.value.key_stores != null ? each.value.key_stores : []
    content {
      dynamic "key_store_content" {
        for_each = key_stores.value.key_store_content != null ? [key_stores.value.key_store_content] : []
        content {
          secret_id  = key_store_content.value.secret_id
          value_type = key_store_content.value.value_type
        }
      }
      dynamic "key_store_password" {
        for_each = key_stores.value.key_store_password != null ? [key_stores.value.key_store_password] : []
        content {
          secret_id  = key_store_password.value.secret_id
          value_type = key_store_password.value.value_type
        }
      }
      key_store_type = key_stores.value.key_store_type
    }
  }

  dynamic "locks" {
    for_each = each.value.locks != null ? each.value.locks : []
    content {
      message             = locks.value.message
      related_resource_id = locks.value.related_resource_id
      time_created        = locks.value.time_created
      type                = locks.value.type
    }
  }

  dynamic "proxy_client" {
    for_each = each.value.proxy_client != null ? [each.value.proxy_client] : []
    content {
      proxy_authentication_type = proxy_client.value.proxy_authentication_type
      roles                     = proxy_client.value.roles
      user_name                 = proxy_client.value.user_name
      dynamic "user_password" {
        for_each = proxy_client.value.user_password != null ? [proxy_client.value.user_password] : []
        content {
          secret_id  = user_password.value.secret_id
          value_type = user_password.value.value_type
        }
      }
    }
  }

  dynamic "related_resource" {
    for_each = each.value.related_resource != null ? [each.value.related_resource] : []
    content {
      entity_type = related_resource.value.entity_type
      identifier  = related_resource.value.identifier
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "user_password" {
    for_each = each.value.user_password != null ? [each.value.user_password] : []
    content {
      secret_id  = user_password.value.secret_id
      value_type = user_password.value.value_type
    }
  }
}

