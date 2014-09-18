require 'spec_helper'

describe "tests/show" do
  before(:each) do
    @test = assign(:test, stub_model(Test,
      :name => "Name",
      :type => "Type",
      :category => "Category",
      :description => "Description",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Type/)
    rendered.should match(/Category/)
    rendered.should match(/Description/)
    rendered.should match(/1/)
  end
end
