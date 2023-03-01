# Creating External LoadBalancer
resource "aws_lb" "externalalb" {
  name               = "ExternalLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.demosg.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id]
}

resource "aws_lb_target_group" "externalalb" {
  name     = "ALBTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.demovpc.id
}

resource "aws_lb_target_group_attachment" "attachment" {
  target_group_arn = aws_lb_target_group.externalalb.arn
  target_id        = aws_instance.demoinstance.id
  port             = 80

  depends_on = [
    aws_instance.demoinstance,
  ]
}

resource "aws_lb_target_group_attachment" "attachment1" {
  target_group_arn = aws_lb_target_group.externalalb.arn
  target_id        = aws_instance.demoinstance1.id
  port             = 80

  depends_on = [
    aws_instance.demoinstance1,
  ]
}

resource "aws_lb_listener" "externalelb" {
  load_balancer_arn = aws_lb.externalalb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.externalalb.arn
  }
}