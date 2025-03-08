# Create a Null Resource and Provisioners
resource "null_resource" "copy_ec2_keys" {
  depends_on = [module.ec2_public]
  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type     = "ssh"
    host     = aws_eip.bastion_eip.public_ip    
    user     = "ec2-user"
    password = ""
    private_key = file("private-key/docker.pem")
  }  

## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "private-key/docker.pem"
    destination = "/tmp/docker.pem"
  }
## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/docker.pem"
    ]
  }
## Local Exec Provisioner:  local-exec provisioner (Creation-Time Provisioner - Triggered during Create Resource)
  provisioner "local-exec" {
    command = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
    working_dir = "local-exec-output-files/"
    #on_failure = continue
  }

}



# resource "null_resource" "copy_ec2_keys" {
#   depends_on = [module.ec2_public]

#   # Connection Block for Provisioners to connect to EC2 Instance
#   connection {
#     type        = "ssh"
#     host        = aws_eip.bastion_eip.public_ip    
#     user        = "ec2-user"
#     private_key = file("private-key/docker.pem")
#   }  

#   ## File Provisioner: Copies the terraform-key.pem file to /tmp/docker.pem
#   provisioner "file" {
#     source      = "private-key/docker.pem"
#     destination = "/tmp/docker.pem"
#   }

#   ## Remote Exec Provisioner: Fix private key permissions and install kubectl
#   provisioner "remote-exec" {
#     inline = [
#       "sudo chmod 400 /tmp/docker.pem",
      
#       # Get EKS cluster version dynamically
#       "EKS_VERSION=$(aws eks describe-cluster --name hr-dev-eksdemo1 --query 'cluster.version' --output text)",
      
#       # Install kubectl for respective EKS version
#       "curl -LO https://dl.k8s.io/release/v${EKS_VERSION}/bin/linux/amd64/kubectl",
#       "chmod +x kubectl",
#       "sudo mv kubectl /usr/local/bin/",
      
#       # Verify installation
#       "kubectl version --client"
#     ]
#   }

#   ## Local Exec Provisioner: Log VPC creation details
#   provisioner "local-exec" {
#     command     = "echo VPC created on `date` and VPC ID: ${module.vpc.vpc_id} >> creation-time-vpc-id.txt"
#     working_dir = "local-exec-output-files/"
#   }
# }
