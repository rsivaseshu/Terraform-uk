# count example
# resource "aws_iam_user" "users" {
#   count = length(var.user_list)
#   name = var.user_list[count.index]

#     tags = {
#     tag-key = "tag-value-${count.index}"
#   }
# }

#for each example
resource "aws_iam_user" "users" {
  for_each = toset( var.user_list )
  name = each.value

}


variable "user_list" {
    type = list(string)
    description = "enter users list"
    default = [ "ram", "siva", "rajesh", "prasad", "Mallika", "Anil" ]
  
}

data "aws_iam_policy_document" "example" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

}

resource "aws_iam_policy" "example_policy" {
  name = "example-policy"
  path = "/sample"
  policy = data.aws_iam_policy_document.example.json
}