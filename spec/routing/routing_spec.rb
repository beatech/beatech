require 'spec_helper'

#    root     /     entries#frontpage
# entries GET /:url entries#show
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
