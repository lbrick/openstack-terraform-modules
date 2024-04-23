variable "project_name" {
  description = "Openstack project Name"
  type        = string
  nullable    = false
}

variable "instance_name" {
  description = "Instance Name"
  type        = string
  nullable    = false
}

variable "flavor_name" {
  description = "OpenStack compute flavor name"
  type        = string
  default     = "balanced1.2cpu4ram"
}

variable "image_id" {
  description = "FlexiHPC Image ID for support test instance, Defaults to NeSI-FlexiHPC-CentOS_Stream-9"
  type        = string
  default     = "2d862f07-99fa-456f-b398-66ddc9683cd4" 
}

variable "instance_volume_size" {
  description = "The size of the support test volume in gigabytes, defaults to 30"
  type        = string
  default     = "30" 
}

variable "key_pair" {
  description = "FlexiHPC SSH Key Pair name"
  type        = string
  nullable    = false
}

variable "key_file" {
  description = "Path to local SSH private key associated with Flexi key_pair, used for configuration"
  type        = string
  nullable    = false
}

variable "secgroups" {
  description = "Names of additional security groups beyond the standard ones"
  type        = list(string)
  default     = []
}