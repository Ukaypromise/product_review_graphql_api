require 'rails_helper'

RSpec.describe Product, type: :model do
  let!(:user) { create(:user, email: "beca@gmail.com", password: "123456") }
  it "is valid with valid attributes" do
    product = build(:product, user_id: user.id)
    expect(product).to be_valid
  end

  it "is not valid without a name attribute" do
    product = build(:product, name: nil, user_id: user.id)
    expect(product).to_not be_valid
  end

  it "is not valid with a duplicate url address" do
    create(:product, url: "https://www.apple.com/macbook-pro-13/", name: "MackBook Pro", user_id: user.id)
    product = build(:product, url: "https://www.apple.com/macbook-pro-13/", name: "MackBook Air", user_id: user.id)
    expect(product).to_not be_valid
  end
end
