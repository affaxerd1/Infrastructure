provider "aws" {
    region= "eu-west-2"

}
#instance
resource "aws_instance" "example" {
    ami     = "ami-053a617c6207ecc7b"
    instance_type = "t2.micro"

    #passing the sec group to vpc to be used by instance<PROVIDER>_<TYPE>.<NAME>.<ATTRIBUTE>
    vpc_security_group_ids = [aws_security_group.instance.id]

#code to run
    user_data = <<-EOF
                #!bin/bash
                echo "Hello world" > index.html
                nohup busybox httpf -f -p 8080 &
                EOF
    #computer launches new instance on any change
    user_data_replace_on_change = true

    tags = {
        Name    =   "Terraform_Example"
    }
}

#security group
resource "aws_security_group" "instance" {
    name = "terraform example instance"

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
