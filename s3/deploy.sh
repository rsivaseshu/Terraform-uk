terraform validate
terraform fmt
terraform plan  -var="owner=rsiva"
terraform apply -var="owner=rsiva" -auto-approve
aws s3 cp documents/index.html s3://rssr-uk-tf-bucket-1  --profile some
aws s3 cp documents/error.html s3://rssr-uk-tf-bucket-1  --profile some