::Route::Router.generate do
  get path: "/users", action: "index", handler: Users
  get path: "/users/:id", action: "show", handler: Users
  post path: "/users", action: "create", handler: Users
end