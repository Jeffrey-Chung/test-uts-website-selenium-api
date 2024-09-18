import json
import boto3

# Get the dynamodb table from our existing infrastructure
table = boto3.resource('dynamodb').Table('jchung_dynamodb_table_for_test_run_count')

def lambda_handler(event, context):
   # Getting the item with count_id of 0
   response = table.get_item(Key={
      'count_id' : '0'
   })
   # Update the number of times the UI test has ran on chrome
   count = response['Item']['chrome_tests_count']
   count = count + 1
   # Shows how many people viewed the site
   print(count)

   # Update dynamodb table with increased views
   response = table.put_item(Item={
      'count_id' : '0',
      'chrome_tests_count' : count
   })
   return response