terraform {
  backend "s3" {
    bucket = "jenkins-terraform-eks-state-file-bucket"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-2"
  }
}