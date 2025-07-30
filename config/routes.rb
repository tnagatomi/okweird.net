Rails.application.routes.draw do
  root "about#index"

  get "blog", to: "posts#index", as: :posts
  get "blog/:year/:month/:slug", to: "posts#show", as: :slugged_post, constraints: { year: /\d{4}/, month: /\d{2}/, slug: /.*/, format: /html/ }
  direct :post do |post, options|
    route_for :slugged_post, { year: post.published_at.strftime("%Y"), month: post.published_at.strftime("%m"), slug: post.slug }.merge(options)
  end

  get "blog/:slug", to: "posts#redirect", constraints: { slug: /.*/ }

  get "history", to: "history#index", as: :history

  get "index", to: "feed#index", as: :feed, format: :xml
  get "sitemap", to: "sitemap#index", as: :sitemap, format: :xml, defaults: { format: :xml }
  get "robots", to: "robots#index", as: :robots, format: :txt, defaults: { format: :txt }
end
