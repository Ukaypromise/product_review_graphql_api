require "rails_helper"

RSpec.describe 'GraphQL User SignIn Mutation', type: :request do
  let!(:user) { create(:user, email: "beca@gmail.com", password: "123456") }

  let(:mutation) do
    <<~MUTATION
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
  end

  def sign_in_user(email:, password:)
      user_params = {
        credentials: {
          email: email,
          password: password
        }
    }

    post "/graphql", params: { query: mutation, variables: { input: user_params } }
  end

  it 'should sign in a user with the correct credentials' do
    sign_in_user(email: "beca@gmail.com", password: "123456")
    expect(response.parsed_body["errors"]).to be_nil

    expect(response.parsed_body["data"]["signInUser"]["token"]).to be_present

    expect(response.parsed_body["data"]["signInUser"]["user"]["email"]).to eq(
      "beca@gmail.com"
    )
  end

  it "should not sign in a user with incorrect credentials" do
    sign_in_user(email: "", password: "")
    expect(response.parsed_body["errors"]).to be_present
  end
end
