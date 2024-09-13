# frozen_string_literal: true

module Mutations
  class ProductDelete < BaseMutation
    description "Deletes a product by ID"

    field :message, String, null: false

    argument :id, ID, required: true

    def resolve(id:)
      product = ::Product.find(id)
      raise GraphQL::ExecutionError.new "Error deleting product", extensions: product.errors.to_hash unless product.destroy!

      { message: "Product deleted successfully" }
    end
  end
end
