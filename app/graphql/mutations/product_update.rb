# frozen_string_literal: true

module Mutations
  class ProductUpdate < BaseMutation
    description "Updates a product by id"

    field :product, Types::ProductType, null: false

    argument :id, ID, required: true
    argument :name, String, required: true
    argument :url, String, required: true

    def resolve(id:, name:, url:)
      product = ::Product.find(id)
      raise GraphQL::ExecutionError.new "Error updating product", extensions: product.errors.to_hash unless product.update(name:, url:)

      { product: product }
    end
  end
end
