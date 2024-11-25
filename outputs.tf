output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnet_ids
}

output "private_subnets" {
  value = module.vpc.private_subnet_ids
}

output "elb_dns_name" {
  value = aws_elb.web.dns_name
}

output "route53_zone_id" {
  value = aws_route53_zone.public.zone_id
}
