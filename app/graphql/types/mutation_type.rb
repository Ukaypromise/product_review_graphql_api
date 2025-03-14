# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :comment_delete, mutation: Mutations::CommentDelete
    field :comment_update, mutation: Mutations::CommentUpdate
    field :comment_create, mutation: Mutations::CommentCreate
    field :sign_in_user, mutation: Mutations::SignInUser
    field :user_create, mutation: Mutations::UserCreate
    field :product_delete, mutation: Mutations::ProductDelete
    field :product_update, mutation: Mutations::ProductUpdate
    field :create_product, mutation: Mutations::CreateProduct
    # TODO: remove me
    field :test_field, String, null: false,
      description: "An example field added by the generator"
    def test_field
      "Hello World"
    end
  end
end
