require 'rails_helper'

RSpec.describe "/comments", type: :request do
  
  describe "GET /index" do
    it "renders a successful response" do
      user = create(:user)
      login_as(user)

      post = build(:post)
      post.author = user
      post.save!

      comment = build(:comment)
      comment.author = user #Commenting on my own post
      post.comments << comment
      
      get post_comments_url(post)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Comment" do
        user = create(:user)
        login_as(user)

        post = build(:post)
        post.author = user
        post.save!

        comment_params = attributes_for(:comment)
        expect {
          post post_comments_url(post), params: { comment: comment_params }
        }.to change(Comment, :count).by(1)
      end
    end
  end
end
