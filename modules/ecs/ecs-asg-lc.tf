## Adding ECS service and task and Cloud Watch configurations
##

### ECS cluster
resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.VPC_NAME}-${var.ENV}-${var.appname}"
}

#Compute
resource "aws_autoscaling_group" "ecs-asg" {
  name                      = "ecs-${var.appname}-${var.ENV}"
  vpc_zone_identifier       = ["${var.public-subnet-1}", "${var.public-subnet-2}"]
  min_size                  = "${var.min_size}"                                    #default 1
  max_size                  = "${var.max_size}"                                    #default 4
  desired_capacity          = "${var.desired_capacity}"                            #default 2
  launch_configuration      = "${aws_launch_configuration.ecs-lc.name}"
  health_check_grace_period = 120
  default_cooldown          = 30
  termination_policies      = ["OldestInstance"]

  tag {
    key                 = "Name"
    value               = "${var.appname}-${var.ENV}-cluster"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "ecs-asg-policy" {
  name                      = "ecs-${var.appname}-${var.ENV}"
  policy_type               = "TargetTrackingScaling"
  estimated_instance_warmup = "90"
  adjustment_type           = "ChangeInCapacity"
  autoscaling_group_name    = "${aws_autoscaling_group.ecs-asg.name}"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = 60.0
  }
}

resource "aws_launch_configuration" "ecs-lc" {
  name_prefix          = "ecs-${var.appname}-${var.ENV}"
  security_groups      = ["${aws_security_group.instance_sg.id}"]

  key_name             = "${aws_key_pair.ecskeypair.key_name}"
  image_id             = "${data.aws_ami.amazon_linux.id}"
  instance_type        = "${var.instance_type}"          # default t2.micro
  iam_instance_profile = "${var.iam_instance_profile}"

  #user_data          = "${data.template_file.ecs-cluster.rendered}"
  associate_public_ip_address = false
}

### AWS linux AMI
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }
  
    filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}