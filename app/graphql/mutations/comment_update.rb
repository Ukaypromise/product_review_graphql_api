# frozen_string_literal: true

module Mutations
  class CommentUpdate < BaseMutation
    description "Updates a comment by id"

    field :comment, Types::CommentType, null: false
    field :errors, [ String ], null: false

    argument :id, ID, required: true
    argument :body, String, required: true

    def resolve(id:, body:)
      comment = ::Comment.find(id)

      if comment.update(body: body)
        { comment: comment, errors: [] }
      else
      raise GraphQL::ExecutionError.new "Error updating comment", extensions: comment.errors.to_hash
      end
    end
  end
end
