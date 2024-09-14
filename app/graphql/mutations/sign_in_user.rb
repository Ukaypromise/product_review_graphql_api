# frozen_string_literal: true

module Mutations
  class SignInUser < BaseMutation
    null true
    argument :credentials, Types::AuthProviderCredentialsInput, required: false

    field :token, String, null: true
    field :user, Types::UserType, null: true

    def resolve(credentials: nil)
      return unless credentials

      user = User.find_by(email: credentials[:email])

      if user && user.authenticate(credentials[:password])
        token = JsonWebToken.encode(user_id: user.id)
        { user: user, token: token }
      else
        raise GraphQL::ExecutionError.new("invalid email or password")
      end
    end
  end
end
