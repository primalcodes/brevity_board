require 'rails_helper'

RSpec.describe "posts/show", type: :view do
  before(:each) do
    post = create(:post)
    @post = assign(:post, post)
    @post.comments << build(:comment)
    @post.comments << build(:comment)
  end

  it "renders attributes" do
    user = create(:user)
    allow(view).to receive(:current_user).and_return(user)

    render    
    expect(rendered).to match(/#{@post.title}/)
    expect(rendered).to match(/#{@post.body}/)
    expect(rendered).to match(/#{@post.author.name}/)    
  end
end
