class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_post_owner, except: %i[index new create show]

  # GET /posts or /posts.json
  def index
    posts_per_page = 20
    @paging = {
        current_page: params.fetch(:page, 0).to_i,
        prev_page: nil,
        next_page: nil 
    }
    posts = Post.includes(:author).offset(@paging[:current_page] * posts_per_page).limit(posts_per_page + 1)
    @paging[:prev_page] = posts.any? && @paging[:current_page] > 0 ? @paging[:current_page] - 1 : nil
    @paging[:next_page] = posts.length > posts_per_page ? @paging[:current_page] += 1 : nil
    posts.to_a.pop
    @posts = posts
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
    render(partial: 'posts/modal_form', locals: { post: @post }, layout: false) if params[:modal].present?
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.author = current_user

    respond_to do |format|
      if @post.save
        format.html do
          redirect_to post_url(@post), notice: 'Post was successfully created.'
        end
        format.json { render :show, status: :created, location: @post }
      else
        format.html do
          render :new, status: :unprocessable_entity
        end
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:user_id, :title, :body)
  end

  def authorize_post_owner
    return if post_owner?(post: @post)

    render_not_found
  end
end
