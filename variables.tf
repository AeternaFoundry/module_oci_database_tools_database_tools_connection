variable "database_tools_database_tools_connections" {
  description = <<EOT
Map of database_tools_database_tools_connections, attributes below
Required:
    - compartment_id
    - display_name
    - type
Optional:
    - advanced_properties
    - authentication_type
    - connection_string
    - defined_tags
    - freeform_tags
    - private_endpoint_id
    - runtime_identity
    - runtime_support
    - url
    - user_name
    - key_stores (block):
        - key_store_content (optional, block):
            - secret_id (optional)
            - value_type (required)
        - key_store_password (optional, block):
            - secret_id (optional)
            - value_type (required)
        - key_store_type (optional)
    - locks (block):
        - message (optional)
        - related_resource_id (optional)
        - time_created (optional)
        - type (required)
    - proxy_client (block):
        - proxy_authentication_type (required)
        - roles (optional)
        - user_name (optional)
        - user_password (optional, block):
            - secret_id (required)
            - value_type (required)
    - related_resource (block):
        - entity_type (optional)
        - identifier (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - user_password (block):
        - secret_id (required)
        - value_type (required)
EOT

  type = map(object({
    compartment_id      = string
    display_name        = string
    type                = string
    advanced_properties = optional(map(string))
    authentication_type = optional(string)
    connection_string   = optional(string)
    defined_tags        = optional(map(string))
    freeform_tags       = optional(map(string))
    private_endpoint_id = optional(string)
    runtime_identity    = optional(string)
    runtime_support     = optional(string)
    url                 = optional(string)
    user_name           = optional(string)
    key_stores = optional(list(object({
      key_store_content = optional(object({
        secret_id  = optional(string)
        value_type = string
      }))
      key_store_password = optional(object({
        secret_id  = optional(string)
        value_type = string
      }))
      key_store_type = optional(string)
    })))
    locks = optional(list(object({
      message             = optional(string)
      related_resource_id = optional(string)
      time_created        = optional(string)
      type                = string
    })))
    proxy_client = optional(object({
      proxy_authentication_type = string
      roles                     = optional(list(string))
      user_name                 = optional(string)
      user_password = optional(object({
        secret_id  = string
        value_type = string
      }))
    }))
    related_resource = optional(object({
      entity_type = optional(string)
      identifier  = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    user_password = optional(object({
      secret_id  = string
      value_type = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.database_tools_database_tools_connections : (
        contains([for v in ["GENERIC_JDBC", "MYSQL", "ORACLE_DATABASE", "POSTGRESQL"] : lower(v)], lower(v.type))
      )
    ])
    error_message = "must be one of: \"GENERIC_JDBC\", \"MYSQL\", \"ORACLE_DATABASE\", \"POSTGRESQL\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_tools_database_tools_connections : (
        v.user_password == null || (contains([for v in ["SECRETID"] : lower(v)], lower(v.user_password.value_type)))
      )
    ])
    error_message = "must be one of: \"SECRETID\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_tools_database_tools_connections : (
        v.key_stores == null || alltrue([for item in v.key_stores : (item.key_store_content == null || (contains([for v in ["SECRETID"] : lower(v)], lower(item.key_store_content.value_type))))])
      )
    ])
    error_message = "must be one of: \"SECRETID\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_tools_database_tools_connections : (
        v.key_stores == null || alltrue([for item in v.key_stores : (item.key_store_password == null || (contains([for v in ["SECRETID"] : lower(v)], lower(item.key_store_password.value_type))))])
      )
    ])
    error_message = "must be one of: \"SECRETID\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_tools_database_tools_connections : (
        v.proxy_client == null || (contains([for v in ["NO_PROXY", "USER_NAME", "USER_NAME_AUTO_DETECT"] : lower(v)], lower(v.proxy_client.proxy_authentication_type)))
      )
    ])
    error_message = "must be one of: \"NO_PROXY\", \"USER_NAME\", \"USER_NAME_AUTO_DETECT\""
  }
  validation {
    condition = alltrue([
      for k, v in var.database_tools_database_tools_connections : (
        v.proxy_client == null || (v.proxy_client.user_password == null || (contains([for v in ["SECRETID"] : lower(v)], lower(v.proxy_client.user_password.value_type))))
      )
    ])
    error_message = "must be one of: \"SECRETID\""
  }
}

