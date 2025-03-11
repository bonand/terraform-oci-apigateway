variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}
variable "private_key_password" {}
variable "region" {}

variable "ociapigateway_config" {

    type = object({
        apigateway_gateways = map(object({

            #Required
            compartment_id = string,
            endpoint_type  = string,
            subnet_id      = string,

            #Optional
            certificate_id = optional(string),

            ca_bundles = optional(map(object({
                #Required
                type = string,

                #Optional
                ca_bundle_id             = optional(string),
                certificate_authority_id = optional(string)
            }))),

            defined_tags = optional(map(string)),
            display_name = optional(string),

            freeform_tags = optional(map(string)),

            network_security_group_ids = optional(list(string)),

            response_cache_details = optional(object({

                #Required
                type = string,

                #Optional
                authentication_secret_id             = optional(string),
                authentication_secret_version_number = optional(string),
                connect_timeout_in_ms                = optional(number),
                is_ssl_enabled                       = optional(bool),
                is_ssl_verify_disabled               = optional(bool),
                read_timeout_in_ms                   = optional(number),
                send_timeout_in_ms                   = optional(number),

                servers = optional(list(object({
                    #Optional
                    host = string
                    port = number
                })))
            })),

            apigateway_deployments = optional(map(object({

                #Required
                compartment_id = string,
                path_prefix    = string,

                #Optional
                display_name = optional(string),

                specification = object({

                    #Optional
                    logging_policies = optional(object({

                        #Optional
                        access_log = optional(object({
                            #Optional
                            is_enabled = optional(bool)
                        })),
                        exceution_log = optional(object({
                            #Optional
                            is_enabled = optional(bool),
                            log_level = optional(string),
                        }))

                    })),

                    request_policies = optional(object({

                        authentication = optional(list(object({

                            #Required
                            type = string,
                            
                            #Optional
                            audiences = optional(string),
                            cache_key = optional(string),
                            function_id = optional(string),
                            is_anonymous_access_allowed = optional(bool),
                            issuers = optional(string),
                            max_clock_skew_in_seconds = optional(string),
                            parameters = optional(string),

                            public_keys = optional(object({
                                #Required
                                type = string,

                                #Optional
                                is_ssl_verify_enabled = optional(bool),
                                keys = optional(set(object({
                                    #Required
                                    format = string,

                                    #Optional
                                    alg = optional(string),
                                    e = optional(string),
                                    key = optional(string),
                                    key_ops = optional(string),
                                    kid = optional(string),
                                    kty = optional(string),
                                    n = optional(string),
                                    use = optional(string)
                                }))),

                                max_cache_duration_in_hours = optional(string),
                                url = optional(string)
                            })),

                            token_auth_scheme = optional(string),
                            token_header = optional(string),
                            token_query_param = optional(string),

                            validation_failure_policy = optional(list(object({
                                #Required
                                type = string,

                                #Optional
                                client_details = optional(object({
                                    #Required
                                    type = string,

                                    #Optional
                                    client_id = optional(string),
                                    client_secret_id = optional(string),
                                    client_secret_version_number = optional(string)
                                })),

                                fallback_redirect_path = optional(string),
                                logout_path = optional(string),
                                max_expiry_duration_in_hours = optional(string),
                                response_code = optional(string),

                                response_header_transformations = optional(map(object({
                                    #Optional
                                    filter_headers = optional(object({
                                        items = optional(list(object({
                                            #Optional
                                            name = optional(string)
                                        }))),
                                        type = optional(string)
                                    })),

                                    rename_headers = optional(object({
                                        #Optional
                                        items = optional(list(object({
                                            #Optional
                                            from = optional(string),
                                            to = optional(string)
                                        })))
                                    })),

                                    set_headers = optional(object({
                                        #Optional
                                        items = optional(list(object({
                                            #Optional
                                            if_exist = optional(bool),
                                            name = optional(string),
                                            values = optional(string)
                                        })))
                                    })),

                                }))),

                                response_message = optional(string),
                                response_type = optional(string),
                                scopes = optional(string),

                                source_uri_details = optional(object({
                                    #Required
                                    type = string,

                                    #Optional
                                    uri = optional(string)
                                })),

                                use_cookies_for_intermediate_steps = optional(string),
                                use_cookies_for_session = optional(string),
                                use_pkce = optional(string)
                            }))),

                            validation_policy = optional(object({
                                #Required
                                type = string,

                                #Optional
                                uri = optional(string),

                                additional_validation_policy = optional(object({
                                    #Optional
                                    audiences = optional(string),
                                    issuers = optional(string),

                                    verify_claims = optional(list(object({
                                        is_required = optional(bool),
                                        key = optional(string),
                                        values = optional(string)
                                    }))),
                                })),

                                client_details = optional(object({
                                    #Required
                                    type = string,

                                    #Optional
                                    client_id = optional(string),
                                    client_secret_id = optional(string),
                                    client_secret_version_number = optional(string)
                                })),

                                is_ssl_verify_disabled = optional(bool),

                                keys = optional(set(object({
                                    #Required
                                    format = string,

                                    #Optional
                                    alg = optional(string),
                                    e = optional(string),
                                    key = optional(string),
                                    key_ops = optional(string),
                                    kid = optional(string),
                                    kty = optional(string),
                                    n = optional(string),
                                    use = optional(string)
                                }))),

                                max_cache_duration_in_hours = optional(string),

                                source_uri_details = optional(object({
                                    #Required
                                    type = string,

                                    #Optional
                                    uri = optional(string)
                                })),
                            })),

                            verify_claims = optional(list(object({
                                    #Optional
                                    is_required = optional(string),
                                    key = optional(string),
                                    values = optional(string)
                            }))),

                        }))),

                        cors = optional(list(object({
                            #Required
                            allowed_origins = string,

                            #Optional
                            allowed_headers = optional(list(string)),
                            allowed_methods = optional(list(string)),
                            exposed_headers = optional(list(string)),
                            is_allow_credentials_enabled = optional(bool),
                            max_age_in_seconds = optional(string)
                        }))),

                        dynamic_authentication = optional(object({
                            #Required
                            authentication_servers = map(object({
                                #Required
                                authentication_server_detail = object({
                                    #Required
                                    type = string,

                                    #Optional
                                    audiences = optional(string),
                                    function_id = optional(string),
                                    is_anonymous_access_allowed = optional(bool),
                                    issuers = optional(string),
                                    max_clock_skew_in_seconds = optional(string),

                                    parameters = optional(map(object({
                                    }))),

                                    public_keys = optional(object({
                                        #Required
                                        type = string,

                                        #Optional
                                        is_ssl_verify_disabled = optional(bool),

                                        keys = optional(set(object({
                                            #Required
                                            format = string,

                                            #Optional
                                            alg = optional(string),
                                            e = optional(string),
                                            key = optional(string),
                                            key_ops = optional(string),
                                            kid = optional(string),
                                            kty = optional(string),
                                            n = optional(string),
                                            use = optional(string)
                                        }))),

                                        max_cache_duration_in_hours = optional(string),
                                        uri = optional(string),
                                    })),

                                    token_auth_scheme = optional(string),
                                    token_header = optional(string),
                                    token_query_param = optional(string),

                                    validation_failure_policy = optional(object({

                                    })),

                                    validation_policy = optional(object({

                                    })),

                                    verify_claims = optional(object({

                                    })),

                                }),
                                key = optional(object({
                                    #Required
                                    name = string,

                                    #Optional
                                    expression = optional(string),
                                    is_default = optional(bool),
                                    type = optional(string),
                                    values = optional(string)

                                })),
                            })),

                            selection_source = optional(object({
                                #Required
                                selector = string,
                                type = string
                            })),


                        })),

                        mutual_tls = optional(object({
                            #Optional
                            allowed_sans = optional(string),
                            is_verified_certificate_required = optional(bool)
                        })),

                        rate_limiting = optional(object({
                            #Required
                            rate_in_requests_per_second = string,
                            rate_key = string
                        })),

                        usage_plan = optional(object({
                            #Required
                            token_locations = string
                        })),

                    })),

                    routes = map(object({
                        #Required
                        path = optional(string),
                        methods = optional(list(string)),

                        backend = map(object({
                            #Required
                            type = string,

                            #Optional
                            allowed_post_logout_uris = optional(string),
                            body = optional(string),
                            connect_timeout_in_seconds = optional(string),
                            function_id = optional(string),

                            headers = optional(list(object({
                                #Optional
                                name = optional(string),
                                value = optional(string)
                            }))),

                            is_ssl_verify_disabled = optional(bool),
                            post_logout_state = optional(string),
                            read_timeout_in_seconds = optional(string),

                            routing_backends = optional(map(object({
                                backend = list(object({
                                    #Required
                                    type = string,

                                    #Optional
                                    body = optional(string),
                                    connect_timeout_in_seconds = optional(string),
                                    function_id = optional(string),

                                    headers = optional(list(object({
                                        #Optional
                                        name = optional(string),
                                        value = optional(string)
                                    }))),

                                    is_ssl_verify_disabled = optional(bool),
                                    read_timeout_in_seconds = optional(string),
                                    send_timeout_in_seconds = optional(string),
                                    status = optional(string),
                                    url = optional(string)
                                })),

                                key = optional(list(object({
                                    #Required
                                    name = string,
                                    type = string,

                                    #Optional
                                    expression = optional(string),
                                    is_default = optional(bool),
                                    values = optional(string)
                                }))),
                            }))),

                            selection_source = optional(list(object({
                                #Required
                                selector = string,
                                type = string
                            }))),

                            send_timeout_in_seconds = optional(string),
                            status = optional(string),
                            url = optional(string)

                        })),

                        logging_policies = optional(list(object({

                        }))),

                        request_policies = optional(list(object({

                        }))),

                        response_policies = optional(list(object({

                        }))),

                    })),
                }),

                defined_tags = optional(map(string)),
                freeform_tags = optional(map(string)),
            }))),

        })),
    })


    #validation {
    #    condition     = contains(["PUBLIC", "PRIVATE"], var.gateway_config.endpoint_type)
    #    error_message = "endpoint_type deve essere 'PUBLIC' o 'PRIVATE'"
    #}
}
