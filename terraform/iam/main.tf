resource "aws_iam_policy" "github_actions_policy" {
  name        = "github-actions-ecr-ecs-eks-policy"
  path        = "/"
  description = "IAM policy for GitHub Actions with ECR, ECS, EC2, and EKS permissions"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["ecr:*"],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ecs:ListClusters",
          "ecs:DescribeClusters",
          "ecs:ListTaskDefinitions",
          "ecs:DescribeTaskDefinition",
          "ecs:RegisterTaskDefinition",
          "ecs:DeregisterTaskDefinition",
          "ecs:ListServices",
          "ecs:DescribeServices",
          "ecs:UpdateService",
          "ecs:CreateService",
          "ecs:DeleteService",
          "ecs:RunTask",
          "ecs:StartTask",
          "ecs:StopTask",
          "ecs:ListTasks",
          "ecs:DescribeTasks"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceStatus",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSubnets",
          "ec2:DescribeVpcs",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeKeyPairs",
          "ec2:DescribeImages"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "eks:ListClusters",
          "eks:DescribeCluster",
          "eks:ListNodegroups",
          "eks:DescribeNodegroup",
          "eks:ListUpdates",
          "eks:DescribeUpdate",
          "eks:AccessKubernetesApi"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "github_actions_role" {
  name = "github-actions-role"
  path = "/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "sts.amazonaws.com"
        },
        Action = "sts:AssumeRole",
        Condition = {
          StringEquals = {
            "sts:ExternalId": "Weather-AP/World_Weather"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github_actions_role_policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}
