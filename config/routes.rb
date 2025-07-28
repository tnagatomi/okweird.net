Rails.application.routes.draw do
  root "about#index"

  get "blog/index", to: "posts#index", as: :posts
  get "blog/:slug", to: "posts#show", as: :post, constraints: { slug: /[a-z0-9\-_]+/ }

  get "history/index"

  get "index", to: "feed#index", as: :feed, format: :xml
  get "sitemap", to: "sitemap#index", as: :sitemap, format: :xml, defaults: { format: :xml }
  get "robots", to: "robots#index", as: :robots, format: :txt, defaults: { format: :txt }
end
