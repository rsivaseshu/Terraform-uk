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
  default = [
    {
    type       = "CanonicalUser"
    permission = "FULL_CONTROL"
    id         = data.aws_canonical_user_id.current.id
    }, 
    
    {
    type       = "CanonicalUser"
    permission = "FULL_CONTROL"
    id         = data.aws_cloudfront_log_delivery_canonical_user_id.cloudfront.id # Ref. https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/AccessLogs.html
    }
  ]
}

variable "website" {
  type = any
  default = {}

}

