class PostsController < ApplicationController
  def index
    @posts = Post.all.sort_by(&:published_at).reverse
  end

  def show
    # remove any trailing extension
    slug_param = params[:slug].sub(/\.[^.]*\z/, "")

    @post = Post.all.find { |post| post.slug == slug_param }
    raise ActionController::RoutingError, "Not Found" unless @post
  end
end
