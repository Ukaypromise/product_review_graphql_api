operation = <<~GQL

query{
  testField
}
GQL

response = ProductReviewSchema.execute(operation)
puts JSON.pretty_generate(response)
