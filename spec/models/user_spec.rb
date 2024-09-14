require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a valid attribute" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "is not valid without a username" do
    user = build(:user, username: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without an email attribute" do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is not valid without an passowrd attribute" do
    user = build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it "is not valid with a duplicate email address" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")

    expect(user).to_not be_valid
  end
end
