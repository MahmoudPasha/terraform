terraform {
  backend "s3" {
    bucket = "pasha-terraform-bucket"
    key = "lab3/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "pasha-terraform-table"
  }
}