#resource "aws_route53_record" "www" {
#  zone_id = "Z10313571AKWZTQJHUCAB"
#  name    = "auth.baseplatform2.irondev.io"
#  type    = "A"
#  ttl     = "60"
#  records = cognito_user_pool.domain.cname
#}