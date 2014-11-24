require 'rails_helper'

RSpec.describe "days/index", :type => :view do
  before(:each) do
    assign(:days, [
      Day.create!(
        :hours_worked => 1.5,
        :day_of_week => 1,
        :business => 2
      ),
      Day.create!(
        :hours_worked => 1.5,
        :day_of_week => 1,
        :business => 2
      )
    ])
  end

  it "renders a list of days" do
    render
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
