require "rails_helper"

RSpec.describe "GraphQL Product Mutation" do
  let!(:user) { create(:user, email: "test1@gmail.com", password: "123456") }
  let!(:product) { Product.create!(name: "MacBook Pro", url: "www.apple.com/macbook-pro", user_id: user.id) }
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
      allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(user)
      expect {
        post "/graphql", params: { query: mutation, variables: { input: product_params } }
      }.to change { Product.count }.by(1)

      response_data = JSON.parse(response.body)
      expect(response_data["error"]).to be_nil
      expect(response.parsed_body["data"]["createProduct"]["product"]).to eq(
        "id" => response_data["data"]["createProduct"]["product"]["id"],
        "name" => "iphone 16",
        "url" => "www.apple.com/iphone-16"
      )
    end
  end

  describe "Update Product" do
    it "should update an existing product" do
      mutation = <<~MUTATION
      mutation($input: ProductUpdateInput!) {
        productUpdate(input: $input){
          product{
            id
            name
            url
          }
        }
      }
      MUTATION

      product_params = {
        id: product.id.to_s,
        name: "MacBook Air",
        url: "www.apple.com/macbook-air"
      }

      post "/graphql", params: { query: mutation, variables: { input: product_params } }

      expect(response.parsed_body["errors"]).to be_blank
      expect(response.parsed_body["data"]["productUpdate"]["product"]).to eq(
        "id" => product.id.to_s,
        "name" => "MacBook Air",
        "url" => "www.apple.com/macbook-air"
      )
    end
  end

  describe "Delete Product" do
    it "should delete a product" do
      mutation = <<~MUTATION
        mutation($input: ProductDeleteInput!){
          productDelete(input: $input){
            message
          }
        }
      MUTATION

      product_params = {
        id: product.id.to_s
      }

      post "/graphql", params: { query: mutation, variables: { input: product_params } }
      expect(response.parsed_body["errors"]).to be_blank
      expect(response.parsed_body["data"]["productDelete"]["message"]).to eq("Product deleted successfully")
      expect(Product.find_by(id: product.id)).to be_nil
    end
  end
end
