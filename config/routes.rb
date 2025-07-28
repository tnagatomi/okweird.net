Rails.application.routes.draw do
  root "about#index"

  get "blog/index", to: "post#index"
  get "blog/:slug", to: "posts#show", as: :post, constraints: { slug: /[a-z0-9\-_]+/ }
end
