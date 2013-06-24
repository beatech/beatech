require 'spec_helper'

describe "contestdate3rds/show" do
  before(:each) do
    @contestdate3rd = assign(:contestdate3rd, stub_model(Contestdate3rd,
      :order => 1,
      :place => "Place"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Place/)
  end
end
