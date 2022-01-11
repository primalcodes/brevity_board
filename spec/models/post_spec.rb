require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "creation" do
    before(:each) do
      @post = FactoryBot.build(:post)
    end

    it "can be created" do
      @post.save      
      expect(@post).to be_valid
    end

    it "cannot be created without title" do      
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it "cannot be created without body" do
      @post.body = nil
      expect(@post).to_not be_valid
    end

    it "cannot be created without author" do
      @post.author = nil
      expect(@post).to_not be_valid
    end
  end
end
