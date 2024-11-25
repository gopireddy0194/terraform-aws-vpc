provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source             = "./vpc"
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
  tags               = var.tags
}

resource "aws_elb" "web" {
  name               = "web-elb"
  availability_zones = module.vpc.public_subnet_ids
  listener {
    instance_port     = 80
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }
  listener {
    instance_port     = 443
    instance_protocol = "HTTPS"
    lb_port           = 443
    lb_protocol       = "HTTPS"
    ssl_certificate_id = var.ssl_certificate_id
  }
  health_check {
    target              = "HTTP:80/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
  instances = []
  tags      = var.tags
}

resource "aws_route53_zone" "public" {
  name = var.domain_name
  tags = var.tags
}

resource "aws_route53_record" "elb" {
  zone_id = aws_route53_zone.public.zone_id
  name    = "www"
  type    = "CNAME"
  ttl     = 300
  records = [aws_elb.web.dns_name]
}
