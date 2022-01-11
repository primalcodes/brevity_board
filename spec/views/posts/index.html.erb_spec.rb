require 'rails_helper'

RSpec.describe "posts/index", type: :view do
  before(:each) do
    user = create(:user)
    allow(view).to receive(:current_user).and_return(user)

    @post1 = build(:post)
    @post1.title = Time.now.to_i
    @post1.save!

    @post2 = build(:post)
    @post2.title = Time.now.to_i
    @post2.save!

    assign(:posts, [@post1, @post2])
    assign(:paging, {})
  end

  it "renders a list of posts" do
    render
    assert_select "#post_#{@post1.id} h5", text: @post1.title, count: 1
    assert_select "#post_#{@post2.id} h5", text: @post2.title, count: 1    
  end
end
