terraform {
        required_providers {
                aws = {
                    source  = "hashicorp/aws"
                    version = "3.12.0"
                }
        }
}

provider "aws" {
    region = var.aws_region
}

#Create the VPC
resource "aws_vpc" "ds_vpc" {
    cidr_block = var.vpc_cidr
    tags       = var.vpc_tags
}

#Private Subnet 1
resource "aws_subnet" "priv_subnet_1" {
    availability_zone = var.priv_subnet_az_1
    cidr_block        = var.priv_subnet_cidr_1
    vpc_id            = aws_vpc.ds_vpc.id

    tags = var.vpc_tags
}

#Private Subnet 2
resource "aws_subnet" "priv_subnet_2" {
    availability_zone = var.priv_subnet_az_2
    cidr_block        = var.priv_subnet_cidr_2
    vpc_id            = aws_vpc.ds_vpc.id

    tags = var.vpc_tags
}

#add 2 more private subnets

#Create the main route table for the VPC
resource "aws_route_table" "main_rt" {
    vpc_id = aws_vpc.ds_vpc.id
}

#Create the Internet Gateway
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.ds_vpc.id
    tags   = var.vpc_tags
}

#Create a route for the route table
resource "aws_route" "r1" {
    route_table_id         = aws_route_table.main_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.gw.id 
}

resource "aws_network_acl" "nacl" {
    vpc_id = aws_vpc.ds_vpc.id
}

