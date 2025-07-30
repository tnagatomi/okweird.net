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

  def redirect
    # remove any trailing extension
    slug_param = params[:slug].sub(/\.[^.]*\z/, "")

    @post = Post.all.find { |post| post.slug == slug_param }

    if @post
      year = @post.published_at.strftime("%Y")
      month = @post.published_at.strftime("%m")
      redirect_to slugged_post_path(year: year, month: month, slug: @post.slug), status: :moved_permanently
    else
      raise ActionController::RoutingError, "Not Found"
    end
  end
end
