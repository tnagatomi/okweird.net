class FeedController < ApplicationController
  def index
    @posts = Post.all.sort_by(&:published_at).reverse.take(10)
  end
end
