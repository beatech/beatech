require 'spec_helper'

describe "contest3rds/index" do
  before(:each) do
    assign(:contest3rds, [
      stub_model(Contest3rd,
        :a_score => 1,
        :a_clear => 2,
        :b_score => 3,
        :b_clear => 4,
        :c_score => 5,
        :c_clear => 6,
        :name => "Name",
        :music => "Music",
        :order => 7,
        :team => "Team",
        :movie_url => "Movie Url"
      ),
      stub_model(Contest3rd,
        :a_score => 1,
        :a_clear => 2,
        :b_score => 3,
        :b_clear => 4,
        :c_score => 5,
        :c_clear => 6,
        :name => "Name",
        :music => "Music",
        :order => 7,
        :team => "Team",
        :movie_url => "Movie Url"
      )
    ])
  end

  it "renders a list of contest3rds" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => 6.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Music".to_s, :count => 2
    assert_select "tr>td", :text => 7.to_s, :count => 2
    assert_select "tr>td", :text => "Team".to_s, :count => 2
    assert_select "tr>td", :text => "Movie Url".to_s, :count => 2
  end
end
