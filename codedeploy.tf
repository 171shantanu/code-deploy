# Creating an codedeploy application
resource "aws_codedeploy_app" "codedeploy_app" {
  name             = "demo-codedeploy"
  compute_platform = "Server"

  tags = {
    "Name" = "demo-codedeploy"
  }
}

#Creating a deployment group

resource "aws_codedeploy_deployment_group" "demo_group" {
  app_name               = aws_codedeploy_app.codedeploy_app.name
  deployment_group_name  = "demo-codedeployment-group"
  deployment_config_name = "CodeDeployDefault.AllAtOnce"
  service_role_arn       = aws_iam_role.codedeploy_role.arn
  deployment_style {
    deployment_type   = "IN_PLACE"
    deployment_option = "WITHOUT_TRAFFIC_CONTROL"
  }
  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "CodeDeploy-Test-instance"
    }
  }
}
