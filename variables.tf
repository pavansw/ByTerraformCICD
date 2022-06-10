variable "region" {
default = "ap-south-1"
type = string
}

variable "accesskey"{
sensitive = true
description = "MEntion your access key of IAM user"

}

variable "secretkey"{
sensitive = true
description = "MEntion your secret key of IAM user"
}

variable "ami" {
default = "ami-068257025f72f470d"
type = string
}

variable "instance_type" {
default = "t2.micro"
type = string
}

variable "key" {
default = "myTerraKey"
type = string
}

variable "cidr_block" {
default = "173.0.0.0/16"
type = string
}

variable "cidr_subnet" {
default = "173.0.1.0/24"
type = string
}

