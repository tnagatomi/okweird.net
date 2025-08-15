class RedirectsController < ApplicationController
  def index
    slug_param = params[:slug].sub(/\.[^.]*\z/, "")
    @post = Post.all.find { |post| post.slug == slug_param }
    if @post
      @redirect_url = "/ja/blog/#{@post.published_at.strftime("%Y")}/#{@post.published_at.strftime("%m")}/#{@post.slug}/"
      render :redirect, layout: false
    else
      raise ActionController::RoutingError, "Not Found"
    end
  end

  def blog_index
    @redirect_url = "/ja/posts/"
    render :redirect, layout: false
  end

  def blog_post
    @redirect_url = "/ja/posts/#{params[:year]}/#{params[:month]}/#{params[:slug]}/"
    render :redirect, layout: false
  end
end
