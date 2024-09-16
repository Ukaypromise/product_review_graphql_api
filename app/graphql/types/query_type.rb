# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [ Types::NodeType, null: true ], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ ID ], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :test_field, String, null: false, description: "An example field added by the generator"
    def test_field
      "Hello GraphQL World!"
    end

    field :products, [ ProductType ], null: false, description: "Retrieve a list of all the products"


    def products
      Product.all
    end

    field :product, ProductType, null: false do
      argument :id, ID, required: true
    end

    def product(id:)
      Product.find(id)
    end

    field :product_count, Integer, null: false, description: "Total number of products"

    def product_count
      Product.count
    end

    field :search_products, resolver: Resolvers::ProductsSearch

    field :all_products, Types::ProductType.collection_type, null: true do
      argument :page, Integer, required: false
      argument :limit, Integer, required: false
    end

    def all_products(page: nil, limit: nil)
      ::Product.page(page).per(limit)
    end
  end
end
