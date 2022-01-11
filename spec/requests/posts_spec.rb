 require 'rails_helper'

RSpec.describe "/posts", type: :request do
 
  describe "GET /index" do
    it "renders a successful response" do
      create(:post)
      get posts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      post = create(:post)
      get post_url(post)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "does not allow unauthenticated users to add a new post" do
      get new_post_url
      expect(response).to_not be_successful
    end

    it "renders a successful response for an authenticated user" do
      user = create(:user)
      login_as(user)
      get new_post_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    context "authenticated" do
      it "render a successful response when post belongs to user" do
        user = create(:user)
        login_as(user)

        post = build(:post)
        post.author = user
        post.save

        get edit_post_url(post)
        expect(response).to be_successful
      end

      it "render an UNsuccessful response when post does NOT belong to user" do
        user = create(:user)
        other_user = create(:user)
        login_as(user)

        post = build(:post)
        post.author = other_user
        post.save
          
        get edit_post_url(post)
        expect(response).to_not be_successful
      end
    end

    describe "unauthenticated" do
      it "does not allow unauthenticated users to edit a post" do
        post = create(:post)
        get edit_post_url(post)
        expect(response).to_not be_successful
      end
    end    
  end

  describe "POST /create" do
    context "with valid parameters" do
      
      it "creates a new Post" do
        user = create(:user)
        login_as(user)   
        expect {
          post posts_url, params: { post: attributes_for(:post) }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        user = create(:user)
        login_as(user)

        post_params = attributes_for(:post)
        post_params[:title] = Time.now.to_i
        post posts_url, params: { post: post_params }
        
        last_post = Post.find_by(title: post_params[:title])
        expect(response).to redirect_to(post_url(last_post  ))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Post" do
        user = create(:user)
        login_as(user) 

        post_params = attributes_for(:post)
        post_params[:title] = nil
        expect {
          post posts_url, params: { post: post_params }
        }.to change(Post, :count).by(0)
      end

      it "returns an unprocessable_entity response" do
        user = create(:user)
        login_as(user) 

        post_params = attributes_for(:post)
        post_params[:title] = nil
        post posts_url, params: { post: post_params }        
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      
      it "updates the requested post" do
        user = create(:user)
        login_as(user)
        post_params = attributes_for(:post)
        
        post = Post.new(post_params)
        post.author = user
        post.save!

        post_params[:title] = Time.now.to_i.to_s     
        patch post_url(post), params: { post: post_params }
        post.reload
        expect(post.title).to eq(post_params[:title])
      end

      it "redirects to the post" do
        user = create(:user)
        login_as(user)
        post_params = attributes_for(:post)
        
        post = Post.new(post_params)
        post.author = user
        post.save!

        patch post_url(post), params: { post: post_params }
        post.reload
        expect(response).to redirect_to(post_url(post))
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable_entity response" do
        user = create(:user)
        login_as(user) 

        post_params = attributes_for(:post)
        post = Post.new(post_params)
        post.author = user
        post.save!

        post_params[:title] = nil
        patch post_url(post), params: { post: post_params }        
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

end
