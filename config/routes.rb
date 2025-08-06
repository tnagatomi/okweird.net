Rails.application.routes.draw do
  # English routes (default)
  root "about#index"

  get "posts", to: "posts#index", as: :posts
  get "posts/:year/:month/:slug", to: "posts#show", as: :slugged_post, constraints: { year: /\d{4}/, month: /\d{2}/, slug: /.*/, format: /html/ }

  get "history", to: "history#index", as: :history

  # Japanese routes
  scope ":locale", locale: /ja/ do
    root "about#index", as: :ja_root

    get "blog", to: "posts#index", as: :ja_posts
    get "blog/:year/:month/:slug", to: "posts#show", as: :ja_slugged_post, constraints: { year: /\d{4}/, month: /\d{2}/, slug: /.*/, format: /html/ }

    get "history", to: "history#index", as: :ja_history
  end

  # Legacy blog redirects
  get "blog", to: "redirects#blog_index"
  get "blog/:year/:month/:slug", to: "redirects#blog_post", constraints: { year: /\d{4}/, month: /\d{2}/, slug: /.*/ }
  get "blog/:slug", to: "redirects#index", constraints: { slug: /.*/ }

  direct :post do |post, options|
    locale = I18n.locale
    if locale == :ja
      route_for :ja_slugged_post, { locale: :ja, year: post.published_at.strftime("%Y"), month: post.published_at.strftime("%m"), slug: post.slug, trailing_slash: true }.merge(options)
    else
      route_for :slugged_post, { year: post.published_at.strftime("%Y"), month: post.published_at.strftime("%m"), slug: post.slug, trailing_slash: true }.merge(options)
    end
  end

  # English feed
  get "feed", to: "feed#index", as: :feed, format: :xml, defaults: { format: :xml }
  
  # Japanese feed  
  scope ":locale", locale: /ja/ do
    get "feed", to: "feed#index", as: :ja_feed, format: :xml, defaults: { format: :xml }
  end
  
  # Legacy feed redirect
  get "index", to: "redirects#feed_legacy"

  get "sitemap", to: "sitemap#index", as: :sitemap, format: :xml, defaults: { format: :xml }
  get "robots", to: "robots#index", as: :robots, format: :txt, defaults: { format: :txt }
end
