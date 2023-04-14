# Creating an codedeploy application

resource "aws_codedeploy_app" "codedeploy_app" {
  name             = "demo-codedeploy"
  compute_platform = "Server"

  tags = {
    "Name" = "demo-codedeploy"
  }
}
