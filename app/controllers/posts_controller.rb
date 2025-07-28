class PostsController < ApplicationController
  def index
    @posts = Post.all.sort_by(&:published_at).reverse
  end

  def show
    @post = Post.all.find { |post| post.filename == params[:slug] }
    raise ActionController::RoutingError, "Not Found" unless @post
  end
end
