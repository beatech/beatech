require 'spec_helper'

describe ApplicationController do
  controller do
    def index
      render :text => "index called"
    end
  end

  describe "#load_entries" do
    it "should assign entries to instance valiables" do
      get :index
      assigns(:circle_menu).should be_a_kind_of(ActiveRecord::Relation::ActiveRecord_Relation_Entry)
      assigns(:communication_menu).should be_a_kind_of(ActiveRecord::Relation::ActiveRecord_Relation_Entry)
      assigns(:contents_menu).should be_a_kind_of(ActiveRecord::Relation::ActiveRecord_Relation_Entry)
      assigns(:header_menu).should be_a_kind_of(ActiveRecord::Relation::ActiveRecord_Relation_Entry)
      assigns(:recent_entries).should be_a_kind_of(ActiveRecord::Relation::ActiveRecord_Relation_Entry)
    end
  end
end
