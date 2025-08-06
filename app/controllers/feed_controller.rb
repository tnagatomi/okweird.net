class FeedController < ApplicationController
  def index
    @posts = posts_for_locale.sort_by(&:published_at).reverse.take(10)
  end

  private

  def posts_for_locale
    I18n.locale == :ja ? Post.japanese : Post.english
  end
end
