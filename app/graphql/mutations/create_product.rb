# frozen_string_literal: true

module Mutations
  class CreateProduct < BaseMutation
    field :product, Types::ProductType, null: false
    field :errors, [ String ], null: false

    argument :name, String, required: true
    argument :url, String, required: true

    def resolve(name:, url:)
      product = Product.new(name: name, url: url)

      if product.save
        { product: product, errors: [] }
      else
        { product: nil, errors: product.errors.full_messages }
      end
    end
  end
end
