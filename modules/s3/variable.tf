variable "create_bucket" {
  description = "Controls if S3 bucket should be created"
  type        = bool
  default     = true
}

variable "bucket_name" {
    type = string
    description = "Enter your bucket name"
}

variable "force_destroy" {
    type = bool
    description = "force destroy deafults to false. if you want to delete your bucket forcefull you can make it true"
    default = false

}

variable "required_tags" {
    type = object({
      costcenter = string
      Team = string
      Env = string
      Project = string
      Purpose = string
    })
    description = "Enter your tags like costcenter, team, env, project, purpose..etc"
}


variable "logging" {
  type = map(string)
  default = {}
  description = "if you bucket logging enter select destination bucket and prefix. prefix if optional"
}

variable "acl" {
  type = string 
  description = "Choose your bucket acl. private, public-read"
  default = "private"
  
}

variable "grant" {
  type = any 
  default = [ ]
}

variable "website" {
  type = any
  default = {}

}

variable "attach_policy" {
  type = bool 
  default = false
}

variable "block_public_acls" {
  type = bool
  default = false
}

variable "block_public_policy" {
  type = bool
  default = false
}

variable "ignore_public_acls" {
  type = bool
  default = false
}

variable "restrict_public_buckets" {
  type = bool 
  default = false
}