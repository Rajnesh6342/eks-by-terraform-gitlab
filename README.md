# Terraform command 
```sh 
./gitlab-terraform.sh init
./gitlab-terraform.sh validate
./gitlab-terraform.sh plan
./gitlab-terraform.sh apply
./gitlab-terraform.sh plan -destroy
./gitlab-terraform.sh destroy  --force
```



# Install Terraform on mack
```sh
Download binary from https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli  follow all steps
Unzip
mv ~/Downloads/terraform /usr/local/bin/
terraform -help
terraform -help plan
```

# Now docker localy and check terraform ie workinng or not
```sh
open -a Docker
mkdir learn-terraform-docker-container
cd learn-terraform-docker-container
touch main.tf
vi main.tf (add some code)
terraform init
terraform validate
terraform apply
```
