# frozen_string_literal: true

module Mutations
  class CommentCreate < BaseMutation
    description "Creates a new comment"

    field :comment, Types::CommentType, null: true
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
      { comment: nil, errors: comment.errors.full_messages}
      end

    rescue ActiveRecord::RecordInvalid => e
      raise GraphQL::ExecutionError.new("Invalid input: #{e.errors.full_messages.join(', ')}")
    end
  end
end
