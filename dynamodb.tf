/*
All the Configuration for the DynamoDB table goes here, 
a table is created with an count_id as a primary key and stores number
of views as count_num
*/

#tfsec:ignore:table-customer-key
resource "aws_dynamodb_table" "jchung_dynamodb_table_for_test_run_count" {
  name           = "jchung_dynamodb_table_for_test_run_count"
  hash_key       = "count_id"
  read_capacity  = 5
  write_capacity = 5

  attribute {
    name = "count_id"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  point_in_time_recovery {
    enabled = true
  }
}

resource "aws_dynamodb_table_item" "dynamodb_items" {
  table_name = aws_dynamodb_table.jchung_dynamodb_table_for_test_run_count.name
  hash_key   = aws_dynamodb_table.jchung_dynamodb_table_for_test_run_count.hash_key

  item = <<ITEM
{
  "count_id": {"S": "0"},
  "firefox_tests_count": {"N": "0"},
  "chrome_tests_count": {"N": "0"}
}
ITEM
}