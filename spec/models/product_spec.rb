require 'rails_helper'

RSpec.describe Product, type: :model do
  it "is valid with valid attributes" do
    product = build(:product)
    expect(product).to be_valid
  end

  it "is not valid without a name attribute" do
    product = build(:product, name: nil)
    expect(product).to_not be_valid
  end

  it "is not valid with a duplicate url address" do
    create(:product, url: "https://www.apple.com/macbook-pro-13/", name: "MackBook Pro")
    product = build(:product, url: "https://www.apple.com/macbook-pro-13/", name: "MackBook Air")
    expect(product).to_not be_valid
  end
end
