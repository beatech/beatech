require 'spec_helper'

#    root     /     entries#frontpage
# entries GET /:url entries#show
describe EntriesController, "routing" do
  it "to #frontpage" do
    get("/").should route_to('entries#frontpage')
  end

  it "to #show" do
    get("/tips").should route_to('entries#show', url: "tips")
  end
end
