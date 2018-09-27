# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

match '/global_search', to: "global_search#index", via: [:get, :post]