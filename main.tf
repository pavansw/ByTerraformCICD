resource "aws_vpc" "vpc" {
        cidr_block = var.cidr_block
        tags = {
        Name = "Pavan-vpc1"
        }
}

resource "aws_internet_gateway" "gateway"{
        vpc_id = aws_vpc.vpc.id
}

resource "aws_route" "route"{
        route_table_id = aws_vpc.vpc.main_route_table_id
        destination_cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gateway.id
}

#data "aws_availability_zones" "availableAZ"{}

#output "AZs" {
#       description = "lets find out no of  AZ in region"
#       value = data.aws_availability_zones.availableAZ.names
#}


resource "aws_subnet" "main" {
#       count = length(data.aws_availability_zones.availableAZ.names)
        vpc_id = aws_vpc.vpc.id
        cidr_block = var.cidr_subnet
#       cidr_block = "173.0.${count.index}.0/24"
        map_public_ip_on_launch = true
#       availability_zone = element(data.aws_availability_zones.availableAZ.names,count.index)
}

resource "aws_security_group" "default" {
        name = "http-https-ssh-allow"
        description = "Allow HTTP, HTTPS and SSH Connections"
        vpc_id = aws_vpc.vpc.id
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }

        ingress {
                from_port = 443
                to_port = 443
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
}

resource "aws_instance" "ec2-instance" {
        ami = var.ami
        instance_type = var.instance_type
        key_name = var.key
        security_groups = [aws_security_group.default.id]
        subnet_id = aws_subnet.main.id
}

