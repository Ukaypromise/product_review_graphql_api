# frozen_string_literal: true

module Mutations
  class UserCreate < BaseMutation
    class AuthProviderSignUpData < Types::BaseInputObject
      argument :credentials, Types::AuthProviderCredentialsInput, required: false
    end

    description "Creates a new user"

    field :user, Types::UserType, null: false
    field :errors, [ String ], null: false
    field :token, String, null: false


    argument :username, String, required: true
    argument :auth_provider, AuthProviderSignUpData

    def resolve(username: nil, auth_provider: nil)
      user = User.new(
        username: username,
        email: auth_provider&.[](:credentials)&.[](:email),
        password: auth_provider&.[](:credentials)&.[](:password)
      )

      if user.save
        token = JsonWebToken.encode(user_id: user.id)
        { user: user, token: token }
      else
        raise GraphQL::ExecutionError.new "Error creating user", extensions: user.errors.to_hash
      end
    end
  end
end
