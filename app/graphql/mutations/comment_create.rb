# frozen_string_literal: true

module Mutations
  class CommentCreate < BaseMutation
    description "Creates a new comment"

    field :comment, Types::CommentType, null: false
    field :errors, [ String ], null: false

    argument :body, String, required: true
    argument :product_id, ID, required: true


    def resolve(body:, product_id:)
      user = context[:current_user]

      raise GraphQL::ExecutionError, "User is not authorized" unless user

      product = Product.find_by(id: product_id)
      raise GraphQL::ExecutionError, "Product not found" unless product

      comment = Comment.new(body: body, user: user, product: product)

      if comment.save
        { comment: comment, errors: [] }
      else
      raise GraphQL::ExecutionError.new "Error creating comment", extensions: comment.errors.to_hash
      end
    end
  end
end
