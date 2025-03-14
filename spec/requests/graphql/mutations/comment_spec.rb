require "rails_helper"

RSpec.describe "GraphQL Comment Mutation", type: :request do
  let!(:user) { create(:user, email: "beca@gmail.com", password: "123456") }
  let!(:product) { create(:product, user_id: user.id) }
  let!(:comment) { create(:comment, body: "Initial comment", product: product, user: user) }

  describe "Create a Comment" do
    it "should create a new comment and increases the count by 1" do
      mutation = <<~MUTATION
        mutation($input: CommentCreateInput!) {
          commentCreate(input: $input){
            comment{
            id
            body
            user{
              id
              email
              username
            }
            product{
              id
              name
              url
            }
          }
          }
        }
      MUTATION

      comment_params ={
        body: "This is a great Product",
        productId: product.id.to_s
      }

      allow_any_instance_of(GraphqlController).to receive(:current_user).and_return(user)

      expect {
        post "/graphql", params: { query: mutation, variables: { input: comment_params } }
    }.to change { Comment.count }.by(1)

      response_data = JSON.parse(response.body)

      expect(response_data["errors"]).to be_nil

      comment_data = response_data["data"]["commentCreate"]["comment"]

      expect(comment_data).to eq(
        "id" => comment_data["id"],
        "body" => "This is a great Product",
        "user" => {
          "id" => user.id.to_s,
          "email" => user.email,
          "username" => user.username
        },
        "product" =>{
          "id" => product.id.to_s,
          "name" => product.name,
          "url" => product.url
        }
      )
    end
  end

  describe "Update a comment" do
    it "should update a coment body" do
      mutation = <<~MUTATION
        mutation($input: CommentUpdateInput!) {
          commentUpdate(input: $input){
            comment{
            id
            body
          }
          }
        }
      MUTATION

      update_params = {
        id: comment.id,
        body: "Updated comment"
      }

      post "/graphql", params: { query: mutation, variables: { input: update_params } }
      response_data = JSON.parse(response.body)
      expect(response_data["data"]["commentUpdate"]["comment"]["body"]).to eq(
        "Updated comment"
      )
    end
  end

  describe "Delete a comment" do
    it "should delete a comment" do
      mutation = <<~MUTATION
        mutation($input: CommentDeleteInput!) {
          commentDelete(input: $input){
            success
            errors
          }
        }
      MUTATION

      delete_params = {
        id: comment.id
      }

      expect {
        post "/graphql", params: { query: mutation, variables: { input: delete_params } }
    }.to change { Comment.count }.by(-1)

    response_date = JSON.parse(response.body)
    expect(response_date["data"]["commentDelete"]["success"]).to be(true)
    end
  end
end
