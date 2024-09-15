require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user, email: "beca@gmail.com", password: "123456") }
  let!(:product) { create(:product, user_id: user.id) }

  it "is valid with vaild attribute" do
    comment = build(:comment, user_id: user.id, product_id: product.id)
    expect(comment).to be_valid
  end

  it "is not valid without a body attribute" do
    comment = build(:comment, body: nil, user_id: user.id, product_id: product.id)
    expect(comment).to_not be_valid
  end
end
