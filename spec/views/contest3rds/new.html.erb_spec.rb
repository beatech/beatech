require 'spec_helper'

describe "contest3rds/new" do
  before(:each) do
    assign(:contest3rd, stub_model(Contest3rd,
      :a_score => 1,
      :a_clear => 1,
      :b_score => 1,
      :b_clear => 1,
      :c_score => 1,
      :c_clear => 1,
      :name => "MyString",
      :music => "MyString",
      :order => 1,
      :team => "MyString",
      :movie_url => "MyString"
    ).as_new_record)
  end

  it "renders new contest3rd form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", contest3rds_path, "post" do
      assert_select "input#contest3rd_a_score[name=?]", "contest3rd[a_score]"
      assert_select "input#contest3rd_a_clear[name=?]", "contest3rd[a_clear]"
      assert_select "input#contest3rd_b_score[name=?]", "contest3rd[b_score]"
      assert_select "input#contest3rd_b_clear[name=?]", "contest3rd[b_clear]"
      assert_select "input#contest3rd_c_score[name=?]", "contest3rd[c_score]"
      assert_select "input#contest3rd_c_clear[name=?]", "contest3rd[c_clear]"
      assert_select "input#contest3rd_name[name=?]", "contest3rd[name]"
      assert_select "input#contest3rd_music[name=?]", "contest3rd[music]"
      assert_select "input#contest3rd_order[name=?]", "contest3rd[order]"
      assert_select "input#contest3rd_team[name=?]", "contest3rd[team]"
      assert_select "input#contest3rd_movie_url[name=?]", "contest3rd[movie_url]"
    end
  end
end
