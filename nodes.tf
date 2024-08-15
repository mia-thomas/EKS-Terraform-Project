
resource "aws_security_group" "notion_task_sg" {
  name   = "allow__https"
  vpc_id = aws_vpc.notion_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_https"
  }
}


resource "aws_launch_template" "nodeconfig" {
  name = "notion_launchtemp"

  image_id = "ami-09665fbe9531ad933"
  instance_type = "t2.micro"
  
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_instance_profile.name
  }

  vpc_security_group_ids   = [aws_security_group.notion_task_sg.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "eks_workernode"
    }
  }

  user_data = filebase64("bash.sh")

depends_on = [aws_eks_cluster.notion_eks_task] 

}

resource "aws_autoscaling_group" "workers" {
  name                 = "worker-group"
  min_size             = 3
  max_size             = 3
  vpc_zone_identifier  = [aws_subnet.private_subnet["eu1a"].id, aws_subnet.private_subnet["eu1b"].id, aws_subnet.private_subnet["eu1c"].id]

  launch_template {
    id      = aws_launch_template.nodeconfig.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }

depends_on = [aws_eks_cluster.notion_eks_task]

}