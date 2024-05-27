resource "aws_iam_group" "fabio-leticia-group" {
  name = "fabio-leticia-group"
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  group      = aws_iam_group.fabio-leticia-group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  
}

resource "aws_iam_group_membership" "fabio-leticia-group-membership" {
  name = "fabio-leticia-group-membership"

  users = [
    aws_iam_user.fabio-leticia-poweruser.name,
  ]

  group = aws_iam_group.fabio-leticia-group.name
}

resource "aws_iam_user" "fabio-leticia-poweruser" {
  name = "fabio-leticia-poweruser"
}

resource "aws_iam_user_policy_attachment" "poweruser_policy_attachment" {
  user       = aws_iam_user.fabio-leticia-poweruser.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}