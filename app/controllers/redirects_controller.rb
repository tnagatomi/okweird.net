class RedirectsController < ApplicationController
  def index
    slug_param = params[:slug].sub(/\.[^.]*\z/, "")
    @post = Post.all.find { |post| post.slug == slug_param }
    if @post
      @redirect_url = post_path(@post)
      render layout: false
    else
      raise ActionController::RoutingError, "Not Found"
    end
  end
end
