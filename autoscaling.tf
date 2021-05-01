data "aws_launch_configuration" "EC2" {
  name                  = "test-launch-config"
  image_id              = "ami-0fab0953c3bb514a9"
  instance_type         = "T2.medium"
}

resource "aws_autoscaling_group" "example" {
  capacity_rebalance  = true
  health_check_type   = "EC2"
  desired_capacity    = 2
  max_size            = 5
  min_size            = 2
  vpc_zone_identifier = [aws_subnet.private-1.id]
}

data "aws_availability_zones" "available" {
  availability_zone = "ap-southeast-1"  
}

resource "aws_autoscaling_group" "example" {
  name_prefix = "example"

  launch_configuration = aws_launch_configuration.EC2.name
  availability_zones   = [data.aws_availability_zones.available.names[0]]

  min_size = 2
  max_size = 5

  tags = [
    {
      key                 = "application"
      value               = "example"
      propagate_at_launch = true
    },
  ]
}

resource "aws_autoscalingplans_scaling_plan" "example" {
  name = "example-dynamic-cost-optimization"

  application_source {
    tag_filter {
      key    = "application"
      values = ["example"]
    }
  }

  scaling_instruction {
    max_capacity       = 5
    min_capacity       = 2
    resource_id        = format("autoScalingGroup/%s", aws_autoscaling_group.example.name)
    scalable_dimension = "autoscaling:autoScalingGroup:DesiredCapacity"
    service_namespace  = "autoscaling"

    target_tracking_configuration {
      predefined_scaling_metric_specification {
        predefined_scaling_metric_type = "ASGTotalCPUUtilization"
      }

      target_value >= 45
    }
  }
}