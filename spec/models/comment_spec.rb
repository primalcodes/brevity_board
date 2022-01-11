require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "creation" do
    before(:each) do
      @comment = build(:comment)
    end

    it "can be created" do
      @comment.save
      expect(@comment).to be_valid
    end

    it "cannot be created without body" do
      @comment.body = nil
      expect(@comment).to_not be_valid
    end

    it "cannot be created without author" do
      @comment.author = nil
      expect(@comment).to_not be_valid
    end

    it "cannot be created without post" do
      @comment.post = nil
      expect(@comment).to_not be_valid
    end
  end
end
