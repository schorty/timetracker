require 'rails_helper'

RSpec.describe "notices/index", :type => :view do
  before(:each) do
    assign(:notices, [
      Notice.create!(
        :title => "Title",
        :content => "MyText",
        :day_id => 1
      ),
      Notice.create!(
        :title => "Title",
        :content => "MyText",
        :day_id => 1
      )
    ])
  end

  it "renders a list of notices" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
