terraform {
        required_providers {
                aws = {
                    source  = "hashicorp/aws" 
                    version = "3.12.0"
                }
        }
}

provider "aws" {
    region = "us-west-1"
}

resource "aws_route_table" "main_rt" {
    vpc_id = module.vpc.vpc_id
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "2.62.0"

    cidr = var.vpc_cidr
    name = var.vpc_name

    azs              = var.vpc_azs
    public_subnets   = var.vpc_public_subnets
    private_subnets  = var.vpc_private_subnets

    enable_nat_gateway = var.vpc_enable_nat_gateway

    tags = var.vpc_tags
}

