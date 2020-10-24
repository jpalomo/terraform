terraform {
        required_providers {
                aws = {
                    source = "hashicorp/aws" 
                }
        }
}

provider "aws" {
    region = "us-west-1"
}

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "2.21.0"

    cidr = var.vpc_cidr
    name = var.vpc_name

    azs              = var.vpc_azs
    public_subnets   = var.vpc_public_subnets
    private_subnets  = var.vpc_private_subnets

    enable_nat_gateway = var.vpc_enable_nat_gateway

    tags = var.vpc_tags
}

