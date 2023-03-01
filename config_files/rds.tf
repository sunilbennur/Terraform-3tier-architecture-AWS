# Creating RDS Instance
resource "aws_db_subnet_group" "mydbserver" {
  name       = "main"
  subnet_ids = [aws_subnet.database-subnet-1.id, aws_subnet.database-subnet-2.id]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "mydbserver" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.mydbserver.name
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  multi_az               = true
  db_name                = "mydb_name"
  username               = "bennur"
  password               = "bennur1234"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database-sg.id]
}