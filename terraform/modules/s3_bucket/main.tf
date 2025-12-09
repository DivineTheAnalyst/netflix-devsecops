resource "aws_s3_bucket" "my_bucket" {
    bucket = "my-unique-bucket-name-123456"
        
    tags = {
        Name        = "My bucket"
        Environment = "Dev"
    }
}