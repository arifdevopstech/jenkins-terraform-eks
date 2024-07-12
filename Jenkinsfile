pipeline {
    agent any
    
    tools {
        terraform 'terraform'
    }
    
    environment {
        AWS_DEFAULT_REGION = "us-east-2"
    }

    stages {
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/arifdevopstech/jenkins-terraform-eks.git'
            }
        }
        
        stage('AWS Credentials') {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws_credentials', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                   script {
                        sh '''
                        aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
                        aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
                        aws configure set region $AWS_DEFAULT_REGION
                        '''
                    }
                }
            }
        }
        
        stage('Initializing Terraform') {
            steps {
                script {
                    dir ('eks-cluster') {
                      sh 'terraform init'
                    }
                }
            }
        }
        
        stage('Validating Terraform') {
            steps {
                script {
                    dir ('eks-cluster') {
                      sh 'terraform validate'
                    }
                }
            }
        }
        
        stage('Terraform Plan') {
            steps {
                script {
                    dir ('eks-cluster') {
                      sh 'terraform plan'
                    }
                }
            }
        }
        
        stage('Create or Destroy the EKS Cluster') {
            steps {
                script {
                    dir ('eks-cluster') {
                      sh 'terraform $action --auto-approve'
                    }
                }
            }
        }
        
        stage('Deploy the application to EKS') {
            steps {
                script {
                    dir ('eks-cluster/k8s-deploy') {
                      sh 'aws eks update-kubeconfig --name my-eks-cluster'
                      sh 'kubectl apply -f deploy.yaml'
                      sh 'kubectl apply -f svc.yml'
                    }
                }
            }
        }
        
        
        
    }
}
