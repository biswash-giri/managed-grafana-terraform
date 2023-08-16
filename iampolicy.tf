resource "aws_iam_policy" "grafana_cw_policy" {
  name        = "grafana_cw_policy"
  path        = "/"
  description = "Allows Amazon Grafana to access CloudWatch"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
    {
        "Effect": "Allow",
        "Action": "sts:AssumeRole",
        "Resource": "arn:aws:iam::${var.organizationid}:role/managedgrafana"
    }
   ]
})
}

# firstrole_accid_isdev
# secondrole_accid_isuat


resource "aws_iam_role" "assume" {
  name = "tf-grafana-assume"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "grafana.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_policy_attachment" "gf_cw_policy_role" {
  name       = "cloudwatch_attachment"
  roles      = [aws_iam_role.assume.name]
  policy_arn = aws_iam_policy.grafana_cw_policy.arn
}

