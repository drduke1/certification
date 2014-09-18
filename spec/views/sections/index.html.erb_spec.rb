require 'spec_helper'

describe "sections/index" do
  before(:each) do
    assign(:sections, [
      stub_model(Section,
        :name => "Name",
        :active => false
      ),
      stub_model(Section,
        :name => "Name",
        :active => false
      )
    ])
  end

  it "renders a list of sections" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
