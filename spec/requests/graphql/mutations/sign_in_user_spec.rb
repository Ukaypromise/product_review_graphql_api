require "rails_helper"

RSpec.describe 'GraphQL User SignIn Mutation', type: :request do
  let!(:user) { create(:user, email: "beca@gmail.com", password: "123456") }
  it 'should sign in a user with the correct credentials' do
    mutation = <<~MUTATION
      mutation($input: SignInUserInput!) {
        signInUser(input: $input) {
          user {
            id
            username
            email
          }
          token
        }
      }
      MUTATION

    user_params = {
        credentials: {
          email: "beca@gmail.com",
          password: "123456"
        }
    }

    post "/graphql", params: { query: mutation, variables: { input: user_params } }

    expect(response.parsed_body["errors"]).to be_nil

    expect(response.parsed_body["data"]["signInUser"]["token"]).to be_present

    expect(response.parsed_body["data"]["signInUser"]["user"]["email"]).to eq(
      user_params[:credentials][:email]
    )
  end
end
