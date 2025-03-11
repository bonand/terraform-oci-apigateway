locals {
    processed_apigateways = {
        for flat_apigateways in flatten([
            for apigateway_key, apigateway_value in var.ociapigateway_config.apigateway_gateways : {
                apigateway_keyid = apigateway_key
                display_name = apigateway_value.display_name
                compartment_id = apigateway_value.compartment_id
                endpoint_type = apigateway_value.endpoint_type
                subnet_id = apigateway_value.subnet_id
                apigateway_deployments = apigateway_value.apigateway_deployments
            }
        ]) : flat_apigateways.apigateway_keyid => flat_apigateways
    } 
}


resource "oci_apigateway_gateway" "these" {
    for_each = local.processed_apigateways
    compartment_id = each.value.compartment_id
    subnet_id = each.value.subnet_id
    endpoint_type = each.value.endpoint_type
}
