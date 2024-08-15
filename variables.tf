#Public Subnet Variables
variable "public_sub_name" {
  description = "Prefix used for all resources names"
  default     = "public"
}

variable "public_subnets" {
  type = map(any)
  default = {
    eu1a = {
      az   = "eu-west-1a"
      cidr = "10.0.7.0/24"
    }
    eu1b = {
      az   = "eu-west-1b"
      cidr = "10.0.8.0/24"
    }
    eu1c = {
      az   = "eu-west-1c"
      cidr = "10.0.9.0/24"
    }
  }
}

#Private Subnet Variables
variable "private_sub_name" {
  description = "Prefix used for all resources names"
  default     = "private"
}

variable "private_subnets" {
  type = map(any)
  default = {
    eu1a = {
      az   = "eu-west-1a"
      cidr = "10.0.1.0/24"
    }
    eu1b = {
      az   = "eu-west-1b"
      cidr = "10.0.2.0/24"
    }
    eu1c = {
      az   = "eu-west-1c"
      cidr = "10.0.3.0/24"
    }
  }
}


#Private Route Table Variables:
variable "priv_route_name" {
  description = "Prefix used for all resources names"
  default     = "private"
}

variable "private_route_tables" {
  type = map(any)
  default = {
    route-1a = {
      cidr = "10.0.4.0/24"
    }
    route-1b = {
      cidr = "10.0.5.0/24"
    }
    route-1c = {
      cidr = "10.0.6.0/24"
    }
  }
}

### next task - I dont need public & private. remove 