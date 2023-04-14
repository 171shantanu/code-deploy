# Data block to get the IAM policy for the role
data "aws_iam_policy" "codedeploy_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

#data block for the assuem role policy
data "aws_iam_policy_document" "instance_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

# IAM role for EC2
resource "aws_iam_role" "codedeploy_role" {
  name                  = "codedeploy_role"
  assume_role_policy    = data.aws_iam_policy_document.instance_assume_role_policy.json
  description           = "Allows CodeDeploy to call AWS services such as Auto Scaling on your behalf."
  force_detach_policies = false
  managed_policy_arns   = [data.aws_iam_policy.codedeploy_policy.arn]

  tags = {
    "Name" = "codedeploy-role"
  }
}
