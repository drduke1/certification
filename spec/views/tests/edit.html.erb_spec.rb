require 'spec_helper'

describe "tests/edit" do
  before(:each) do
    @test = assign(:test, stub_model(Test,
      :name => "MyString",
      :type => "",
      :category => "MyString",
      :description => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit test form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", test_path(@test), "post" do
      assert_select "input#test_name[name=?]", "test[name]"
      assert_select "input#test_type[name=?]", "test[type]"
      assert_select "input#test_category[name=?]", "test[category]"
      assert_select "input#test_description[name=?]", "test[description]"
      assert_select "input#test_user_id[name=?]", "test[user_id]"
    end
  end
end
