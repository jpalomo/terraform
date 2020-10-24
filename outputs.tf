output "vpc_public_subnets" {
    description = "IDs of the VPC's pubic subnets"
    value       = module.vpc.public_subnets
}

