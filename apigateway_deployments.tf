locals {
    processed_deployments = {
        for flat_deployments in flatten([
            for apigateway_key, apigateway_value in local.processed_apigateways : [
                for deployment_key, deployment_value in apigateway_value.apigateway_deployments : {
                    deployment_keyid = deployment_key
                    apigateway_keyid = apigateway_value.apigateway_keyid
                    display_name = deployment_value.display_name
                    compartment_id = deployment_value.compartment_id
                    path_prefix = deployment_value.path_prexfix
                }
            ]
        ]) : flat_deployments.deployment_keyid => flat_deployments 
    }
}

resource "oci_apigateway_deployment" "these" {

    for_each = local.processed_deployments
    gateway_id = oci_apigateway_gateway.these[each.value.apigateway_keyid].id
    compartment_id = each.value.compartment_id
    display_name = each.value.display_name
    path_prefix = each.value.path_prefix


    specification {
        logging_policies {
        #access_log = <<Optional value not found in discovery>>
        execution_log {
            #is_enabled = <<Optional value not found in discovery>>
            log_level = "INFO"
        }
        }
        request_policies {
        #authentication = <<Optional value not found in discovery>>
        #cors = <<Optional value not found in discovery>>
        #dynamic_authentication = <<Optional value not found in discovery>>
        mutual_tls {
            allowed_sans = [
            ]
            is_verified_certificate_required = "false"
        }
        #rate_limiting = <<Optional value not found in discovery>>
        #usage_plans = <<Optional value not found in discovery>>
        }
        routes {

            methods = ["GET","PUT"]
            path = "/test"

            backend {
                #allowed_post_logout_uris = <<Optional value not found in discovery>>
                #body = <<Optional value not found in discovery>>
                connect_timeout_in_seconds = "60"
                #function_id = <<Optional value not found in discovery>>
                #headers = <<Optional value not found in discovery>>
                is_ssl_verify_disabled = "false"
                #post_logout_state = <<Optional value not found in discovery>>
                read_timeout_in_seconds = "10"
                #routing_backends = <<Optional value not found in discovery>>
                #selection_source = <<Optional value not found in discovery>>
                send_timeout_in_seconds = "10"
                #status = <<Optional value not found in discovery>>
                type = "HTTP_BACKEND"
                url  = "https://pippo.url"
            }

            logging_policies {
                #access_log = <<Optional value not found in discovery>>
                execution_log {
                #is_enabled = <<Optional value not found in discovery>>
                log_level = ""
                }
            }
        
            request_policies {
                #authorization = <<Optional value not found in discovery>>
                #body_validation = <<Optional value not found in discovery>>
                #cors = <<Optional value not found in discovery>>
                #header_transformations = <<Optional value not found in discovery>>
                #header_validations = <<Optional value not found in discovery>>
                #query_parameter_transformations = <<Optional value not found in discovery>>
                #query_parameter_validations = <<Optional value not found in discovery>>
                #response_cache_lookup = <<Optional value not found in discovery>>
            }
            response_policies {
                #header_transformations = <<Optional value not found in discovery>>
                #response_cache_store = <<Optional value not found in discovery>>
            }
        }
    }
}
