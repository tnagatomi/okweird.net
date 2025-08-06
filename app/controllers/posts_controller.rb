class PostsController < ApplicationController
  def index
    @posts = posts_for_locale.sort_by(&:published_at).reverse
  end

  def show
    # remove any trailing extension
    slug_param = params[:slug].sub(/\.[^.]*\z/, "")

    @post = posts_for_locale.find { |post| post.slug == slug_param }
    raise ActionController::RoutingError, "Not Found" unless @post
  end

  private

  def posts_for_locale
    I18n.locale == :ja ? Post.japanese : Post.english
  end
end
