require "search_object"
require "search_object/plugin/graphql"

class Resolvers::ProductsSearch < GraphQL::Schema::Resolver
  include SearchObject.module(:graphql)

  type [ Types::ProductType ], null: false

  scope { Product.all }

  class ProductFilter < ::Types::BaseInputObject
    argument :OR, [ self ], required: false
    argument :name_contains, String, required: false
    argument :url_contains, String, required: false
  end

  option :filter, type: ProductFilter, with: :apply_filter

  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches=[])
    scope = Product.all
    scope= scope.where("name LIKE ?", "#{value[:name_contains]}") if value[:name_contains]
    scope= scope.where("url LIKE ?", "#{value[:url_contains]}") if value[:url_contains]

    branches << scope

    if value[:OR].present?
      value[:OR].reduce(branches) { |s, v| normalize_filters(v, s)}
    end

    branches
  end
end
