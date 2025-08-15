Rails.application.routes.draw do
  scope "(:locale)", locale: /en|ja/ do
    root "about#index"

    get "posts", to: "posts#index", as: :posts
    get "posts/:year/:month/:slug", to: "posts#show", as: :slugged_post, constraints: { year: /\d{4}/, month: /\d{2}/, slug: /.*/, format: /html/ }

    get "history", to: "history#index"

    get "feed", to: "feed#index", as: :feed, format: :xml, defaults: { format: :xml }
  end

  direct :post do |post, options|
    route_for :slugged_post, { locale: I18n.locale, year: post.published_at.strftime("%Y"), month: post.published_at.strftime("%m"), slug: post.slug, trailing_slash: true }.merge(options)
  end

  # Legacy Japanese blog redirects
  scope ":locale", locale: /ja/ do
    get "blog",  to: "redirects#blog_index"
    get "blog/:year/:month/:slug", to: "redirects#blog_post", constraints: { year: /\d{4}/, month: /\d{2}/, slug: /.*/, format: /html/ }
  end
  get "blog", to: "redirects#blog_index"
  get "blog/:year/:month/:slug", to: "redirects#blog_post", constraints: { year: /\d{4}/, month: /\d{2}/, slug: /.*/ }
  get "blog/:slug", to: "redirects#index", constraints: { slug: /.*/ }

  # Legacy Japanese feed
  get "index", to: "feed#index", format: :xml, defaults: { format: :xml, locale: :ja }

  get "sitemap", to: "sitemap#index", as: :sitemap, format: :xml, defaults: { format: :xml }
  get "robots", to: "robots#index", as: :robots, format: :txt, defaults: { format: :txt }
end
