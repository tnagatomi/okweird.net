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

  def blog_index
    @redirect_url = "/ja/blog/"
    render :redirect, layout: false
  end

  def blog_post
    @redirect_url = "/ja/blog/#{params[:year]}/#{params[:month]}/#{params[:slug]}/"
    render :redirect, layout: false
  end

  def feed_legacy
    @redirect_url = "/ja/feed.xml"
    render :redirect, layout: false, formats: [ :html ]
  end
end
