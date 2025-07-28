class PostController < ApplicationController
  def index
    @posts = Post.all.sort_by(&:published_at).reverse
  end

  def show
  end
end
