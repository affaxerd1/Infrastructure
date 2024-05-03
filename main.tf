provider "aws" {
    region= "eu-west-2"

}

resource "aws_instance" "example" {
    ami     = "ami-053a617c6207ecc7b"
    instance_type = "t2.micro"

    user_data = <<-EOF
                #!bin/bash
                echo "Hello world" > index.html
                nohup busybox httpf -f -p 8080 &
                EOF
    user_data_replace_on_change = true

    tags = {
        Name    =   "Terraform_Example"
    }
}
