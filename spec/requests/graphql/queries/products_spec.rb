require 'rails_helper'

RSpec.describe "GraphQl Product query" do
  let!(:user) { create(:user, email: "test1@gmail.com", password: "123456") }
  let!(:product) { Product.create!(name: "Macbook Pro", url: "www.apple/mackbook-pro.com", user_id: user.id) }

  it "retrieve a list of products" do
    query = <<~QUERY

    query{
      products {
        name
        url
      }
    }
    QUERY

    post "/graphql", params: { query: query }
    expect(response.parsed_body['errors']).to be_blank
    expect(response.parsed_body["data"]).to eq(
      "products" => [
        {
          "name" => product.name,
          "url" => product.url
        }
      ]
    )
  end

  it "should retrieve a single product" do
    query = <<~QUERY

    query($id: ID!){
      product(id: $id) {
        name
        url
      }
    }
    QUERY

    post "/graphql", params: { query: query, variables: { id: product.id } }
    expect(response.parsed_body["errors"]).to be_blank
    expect(response.parsed_body["data"]).to eq(
      "product" =>{
        "name" => product.name,
        "url" => product.url
      }
    )
  end
end
