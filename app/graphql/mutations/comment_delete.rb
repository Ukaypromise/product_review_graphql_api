# frozen_string_literal: true

module Mutations
  class CommentDelete < BaseMutation
    description "Deletes a comment by ID"

    field :success, Boolean, null: false
    field :errors, [ String ], null: false

    argument :id, ID, required: true

    def resolve(id:)
      comment = ::Comment.find(id)

      if comment.destroy
        { success: true, errors: []}
      else
      raise GraphQL::ExecutionError.new "Error deleting comment", extensions: comment.errors.to_hash
      end
    end
  end
end
