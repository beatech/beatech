require "spec_helper"

describe Contest3rdsController do
  describe "routing" do

    it "routes to #index" do
      get("/contest3rds").should route_to("contest3rds#index")
    end

    it "routes to #new" do
      get("/contest3rds/new").should route_to("contest3rds#new")
    end

    it "routes to #show" do
      get("/contest3rds/1").should route_to("contest3rds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/contest3rds/1/edit").should route_to("contest3rds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/contest3rds").should route_to("contest3rds#create")
    end

    it "routes to #update" do
      put("/contest3rds/1").should route_to("contest3rds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/contest3rds/1").should route_to("contest3rds#destroy", :id => "1")
    end

  end
end
