# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :url, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :review_requested_by, UserType, null: true, method: :user
    field :comment_count, Integer, null: false
    field :comments, [ CommentType ], null: false

    def comment_count
      object.comments.count
    end
  end
end
