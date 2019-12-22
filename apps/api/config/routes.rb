get "/auth/failure", to: "sessions#failure"
delete "/auth/logout", to: "sessions#destroy"
get "/auth/:provider/callback", to: "sessions#new"
