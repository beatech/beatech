require 'spec_helper'

describe "contestdate3rds/new" do
  before(:each) do
    assign(:contestdate3rd, stub_model(Contestdate3rd,
      :order => 1,
      :place => "MyString"
    ).as_new_record)
  end

  it "renders new contestdate3rd form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contestdate3rds_path, "post" do
      assert_select "input#contestdate3rd_order[name=?]", "contestdate3rd[order]"
      assert_select "input#contestdate3rd_place[name=?]", "contestdate3rd[place]"
    end
  end
end
