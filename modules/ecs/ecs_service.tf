## Adding ECS service and task
##

### ecs Service
resource "aws_ecs_service" "ecs_service" {
  name            = "${var.VPC_NAME}-${var.ENV}-${var.appname}"
  cluster         = "${aws_ecs_cluster.ecs-cluster.id}"
  task_definition = "${aws_ecs_task_definition.ecs_task.arn}"
  desired_count   = "${var.desired_count}"
  launch_type     = "${var.launch_type}" # valid values are EC2 and FARGATE
  iam_role        = "${aws_iam_role.ec2_role.arn}"

  depends_on      = ["aws_iam_policy_attachment.policy-attachment"]

  load_balancer {
    target_group_arn = "${var.target_group}"
    container_name   = "${var.container_name}"
    container_port   = "${var.container_port}"
  }
  lifecycle {
    ignore_changes = ["task_definition"]
  }
}

resource "aws_ecs_task_definition" "ecs_task" {
  family = "${var.ecs_task_family}"

  container_definitions = "${var.container_definitions}"
}
