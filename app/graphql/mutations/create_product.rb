# frozen_string_literal: true

module Mutations
  class CreateProduct < BaseMutation
    description "Create a Product"
    field :product, Types::ProductType, null: true
    field :errors, [ String ], null: false
    field :review_requested_by, Types::UserType, null: true, method: :user

    argument :name, String, required: true
    argument :url, String, required: true

    def resolve(name:, url:)
      product = Product.new(name: name, url: url, user: context[:current_user])

      if product.save
        { product: product, errors: [] }
      else
        { product: nil, errors: product.errors.full_messages }
      end
    rescue ActiveRecord::RecordInvalid => e
      raise GraphQL::ExecutionError.new("Invalid input: #{e.errors.full_messages.join(', ')}")
    end
  end
end
