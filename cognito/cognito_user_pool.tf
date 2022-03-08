
module "cognito_user_pool" {
  source  = "mineiros-io/cognito-user-pool/aws"
  version = "~> 0.9.0"

  name = format("%s-user-pool", var.prefix)

  # We allow the public to create user profiles
  allow_admin_create_user_only = false
  enable_username_case_sensitivity = false
  advanced_security_mode           = "OFF"

  alias_attributes = [
    "email",
    "phone_number"
  ]

  auto_verified_attributes = [
    "email"
  ]

  account_recovery_mechanisms = [
    {
      name     = "verified_email"
      priority = 1
    },
    {
      name     = "verified_phone_number"
      priority = 2
    }
  ]

  # If invited by an admin
  invite_email_subject = "You've been invited to IronNet"
  invite_email_message = "Hi {username}, your temporary password is '{####}'."
  invite_sms_message   = "Hi {username}, your temporary password is '{####}'."

  domain                = "auth.baseplatform2.irondev.io"
  certificate_arn       = "arn:aws:acm:us-east-1:442507722261:certificate/8b40edb5-c7b4-47ce-85be-0718ba3ad94e"
  default_email_option  = "CONFIRM_WITH_LINK"
  email_subject_by_link = "Your Verification Link"
  email_message_by_link = "Please click the link below to verify your email address. {##Verify Email##}."
  sms_message           = "Your verification code is {####}."

  challenge_required_on_new_device = true
  user_device_tracking             = "USER_OPT_IN"

  # These paramters can be used to configure SES for emails
  # email_sending_account  = "DEVELOPER"
  # email_reply_to_address = "support@mineiros.io"
  # email_from_address     = "noreply@mineiros.io"
  # email_source_arn       = "arn:aws:ses:us-east-1:999999999999:identity"

  # Require MFA
  mfa_configuration        = "OPTIONAL"
  allow_software_mfa_token = true

  password_minimum_length    = 8
  password_require_lowercase = false
  password_require_numbers   = false
  password_require_uppercase = false
  password_require_symbols   = false

  temporary_password_validity_days = 1

#TODO: Test changing this
#  schema_attributes = [
#    {
#      name                     = "email"
#      type = "String"
#      required                 = true
#    },
#    {
#      name                     = "phone_number"
#      type = "String"
#      required                 = false
#    },
#    {
#      name = "customer_name"
#      type = "String"
#      min_length               = 0
#      max_length               = 40
#    },
#    {
#      name = "user_type"
#      type = "String"
#      min_length               = 0
#      max_length               = 40
#    },
#    {
#      name = "last_seen"
#      type = "DateTime"
#    }
#  ]

  clients = [
    { name = "ios" },
    { name = "android" },
    { name = "web" },
  ]

  default_client_read_attributes        = ["email", "email_verified", "preferred_username"]
  default_client_access_token_validity  = 60
  default_client_allowed_oauth_scopes   = ["email", "openid"]
  default_client_allowed_oauth_flows    = ["code", "implicit"]
#  default_client_callback_urls          = [aws_api_gateway_deployment.apigw.invoke_url, "${aws_api_gateway_deployment.apigw.invoke_url}/callback"]
#  default_client_default_redirect_uri   = "${aws_api_gateway_deployment.apigw.invoke_url}/callback"
  default_client_callback_urls          = ["https://mn-ook.baseplatform2.irondev.io/oauth2/idpresponse"]
#  default_client_default_redirect_uri   = "http://localhost"
  default_client_explicit_auth_flows    = ["ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_USER_PASSWORD_AUTH"]
  default_client_generate_secret        = true
  default_client_id_token_validity      = 60
  default_client_refresh_token_validity = 45
  default_client_allowed_oauth_flows_user_pool_client = true
  default_client_supported_identity_providers = ["COGNITO"]
  default_client_token_validity_units = {
    refresh_token = "days"
    access_token  = "minutes"
    id_token      = "minutes"
  }

  tags = {
    environment = var.prefix
  }
}
