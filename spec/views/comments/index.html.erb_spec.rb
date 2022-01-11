require 'rails_helper'

RSpec.describe "comments/index", type: :view do
  before(:each) do
    @post = create(:post)
    @post.comments << build(:comment)
    @post.comments << build(:comment)
    assign(:post, @post)
    assign(:comments, @post.comments)
    assign(:comment, Comment.new)
  end

  it "renders a list of comments" do
    user = create(:user)
    allow(view).to receive(:current_user).and_return(user)

    render
    expect(rendered).to match(/#{@post.comments.first.author.name}/)
    expect(rendered).to match(/#{@post.comments.last.author.name}/)    
  end
end
