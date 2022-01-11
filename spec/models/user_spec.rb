require 'rails_helper'

RSpec.describe User, type: :model do
  describe "creation" do
    before(:each) do
      @user = FactoryBot.build(:user)
    end

    it "has correct initials for multi word name" do
      @user.name = "Joe Example"
      expect(@user.initials).to eq('JE')
    end

    it "has correct initials for single word name" do
      @user.name = "Joe"
      expect(@user.initials).to eq('J')
    end

    it "can be created" do
      @user.save
      expect(@user).to be_valid
    end

    it "cannot be created without name" do      
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it "cannot be created without email" do
      @user.email = nil
      expect(@user).to_not be_valid
    end

    it "cannot be created without password" do
      @user.password = nil
      expect(@user).to_not be_valid
    end
  end
end
