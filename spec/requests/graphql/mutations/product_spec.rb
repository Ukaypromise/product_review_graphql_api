require "rails_helper"

RSpec.describe "GraphQL Product Mutation" do
  describe "Create a Product" do
    it "should create a new product and increase the product count by 1" do
      mutation = <<~MUTATION
      mutation($input: CreateProductInput!) {
        createProduct(input: $input){
          product{
            id
            name
            url
          }
        }
      }
      MUTATION

      product_params ={
        name: "iphone 16",
        url: "www.apple.com/iphone-16"
      }
      expect {
        post "/graphql", params: { query: mutation, variables: { input: product_params } }
    }.to change { Product.count }.by(1)
    expect(response.parsed_body["error"]).to be_blank
    expect(response.parsed_body["data"]["createProduct"]["product"]).to eq(
      "id" => response.parsed_body["data"]["createProduct"]["product"]["id"],
      "name" => "iphone 16",
      "url" => "www.apple.com/iphone-16"
    )
    end
  end
end
