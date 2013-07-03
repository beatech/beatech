require 'spec_helper'

describe "contest3rds/show" do
  before(:each) do
    @contest3rd = assign(:contest3rd, stub_model(Contest3rd,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/4/)
    rendered.should match(/5/)
    rendered.should match(/6/)
    rendered.should match(/Name/)
    rendered.should match(/Music/)
    rendered.should match(/7/)
    rendered.should match(/Team/)
    rendered.should match(/Movie Url/)
  end
end
