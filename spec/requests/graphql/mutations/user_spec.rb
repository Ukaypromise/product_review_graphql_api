require "rails_helper"

RSpec.describe 'GraphQL User Mutation', type: :request do
  it 'should create a new user and increase the user count by 1' do
    mutation = <<~MUTATION
      mutation($input: UserCreateInput!) {
        userCreate(input: $input) {
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
      username: "Test User",
      authProvider: {
        credentials: {
          email: "uka@gmail.com",
          password: "123456"
        }
      }
    }

    expect {
      post "/graphql", params: { query: mutation, variables: { input: user_params } }
      puts "#{response.parsed_body}"
    }.to change { User.count }.by(1)

    expect(response.parsed_body["errors"]).to be_blank

    expect(response.parsed_body["data"]["userCreate"]["token"]).to be_present
  end
end
