# root / entries#frontpage
describe EntriesController, "routing" do
  it "to #index" do
    get("/").should route_to('entries#frontpage')
  end
end
