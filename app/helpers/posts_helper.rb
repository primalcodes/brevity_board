module PostsHelper
  def post_hx_details(post:)
    return {} unless htmx_request?

    if post.new_record?
      { 'hx-post': posts_path, 'hx-target': '#posts', 'hx-swap': 'beforebegin' }
    else
      { 'hx-patch': post_path(post), 'hx-target': "#post_#{post.id}", 'hx-swap': 'outerHTML' }
    end
  end
end
