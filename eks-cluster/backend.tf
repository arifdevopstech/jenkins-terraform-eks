terraform {
  backend "s3" {
    bucket = "jenkins-terraform-eks-state-file-bucket"
    key    = "eks/terraform.tfstate"
    region = "us-east-2"


  }
}