provider "aws" {
  region = "us-east-1"
}

# Create ECR Repository for Docker images
resource "aws_ecr_repository" "laravel_repo" {
  name = "laravel-repo"
}

# Create RDS MySQL Instance
resource "aws_db_instance" "laravel_db" {
  engine         = "mysql"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  name            = "laravel_db"
  username        = "admin"
  password        = "Gajen@97"
}

# Create EKS Cluster
resource "aws_eks_cluster" "laravel_eks" {
  name     = "laravel-cluster"
  role_arn = "arn:aws:iam::971422685560D:role/eks-service-role"
  vpc_config {
    subnet_ids = ["subnet-014c16cda66c7f078", "subnet-0250022499a3db7f3"]
  }
}

# Create Node Group for EKS
resource "aws_eks_node_group" "laravel_node_group" {
  cluster_name = aws_eks_cluster.laravel_eks.name
  node_role_arn = "arn:aws:iam::971422685560:role/eks-node-role"
  subnet_ids    = ["subnet-014c16cda66c7f078", "subnet-0250022499a3db7f3"]
  instance_types = ["t3.medium"]
}
