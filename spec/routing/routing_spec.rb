require 'spec_helper'

#    entries GET    /entries(.:format)     entries#index
#            POST   /entries(.:format)     entries#create
#  new_entry GET    /entries/new(.:format) entries#new
# edit_entry GET    /:id/edit(.:format)    entries#edit {:id=>/[^\/]+/}
#      entry GET    /:id(.:format)         entries#show {:id=>/[^\/]+/}
#            PATCH  /:id(.:format)         entries#update {:id=>/[^\/]+/}
#            PUT    /:id(.:format)         entries#update {:id=>/[^\/]+/}
#            DELETE /:id(.:format)         entries#destroy {:id=>/[^\/]+/}
#       root GET    /                      entries#frontpage
describe EntriesController, "routing" do
  it "to #frontpage" do
    get("/").should route_to('entries#frontpage')
  end

  it "to #index" do
    get("/entries").should route_to('entries#index')
  end

  it "to #create" do
    post("/entries").should route_to('entries#create')
  end

  it "to #new" do
    get("/entries/new").should route_to('entries#new')
  end

  it "to #edit" do
    get("/tips/edit").should route_to('entries#edit', id: 'tips')
  end

  it "to #show" do
    get("/tips").should route_to('entries#show', id: 'tips')
  end

  it "to #update" do
    patch("/tips").should route_to('entries#update', id: 'tips')
  end

  it "to #destroy" do
    delete("/tips").should route_to('entries#destroy', id: 'tips')
  end
end

# session POST   /session(.:format)     sessions#create
#         DELETE /session(.:format)     sessions#destroy
describe SessionsController, "routing" do
  it "to #create" do
    post("/session").should route_to('sessions#create')
  end

  it "to #destroy" do
    delete("/session").should route_to('sessions#destroy')
  end
end

# setting GET    /settings/:item(.:format)              users#edit
#         POST   /settings/:item(.:format)              users#update
describe UsersController, "routing" do
  it "to #edit" do
    get("/settings/profile").should  route_to('users#edit', item: 'profile')
    get("/settings/username").should route_to('users#edit', item: 'username')
    get("/settings/password").should route_to('users#edit', item: 'password')
  end

  it "to #update" do
    patch("/settings/profile").should  route_to('users#update', item: 'profile')
    patch("/settings/username").should route_to('users#update', item: 'username')
    patch("/settings/password").should route_to('users#update', item: 'password')
  end
end
