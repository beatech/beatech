require "spec_helper"

describe Contestdate3rdsController do
  describe "routing" do

    it "routes to #index" do
      get("/contestdate3rds").should route_to("contestdate3rds#index")
    end

    it "routes to #new" do
      get("/contestdate3rds/new").should route_to("contestdate3rds#new")
    end

    it "routes to #show" do
      get("/contestdate3rds/1").should route_to("contestdate3rds#show", :id => "1")
    end

    it "routes to #edit" do
      get("/contestdate3rds/1/edit").should route_to("contestdate3rds#edit", :id => "1")
    end

    it "routes to #create" do
      post("/contestdate3rds").should route_to("contestdate3rds#create")
    end

    it "routes to #update" do
      put("/contestdate3rds/1").should route_to("contestdate3rds#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/contestdate3rds/1").should route_to("contestdate3rds#destroy", :id => "1")
    end

  end
end
