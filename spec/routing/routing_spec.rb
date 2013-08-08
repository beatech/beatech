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

describe SessionsController, "routing" do
  it "to #create" do
    post("/sessions/create").should route_to('sessions#create')
  end

  it "to #destroy" do
    delete("/sessions/destroy").should route_to('sessions#destroy')
  end
end
