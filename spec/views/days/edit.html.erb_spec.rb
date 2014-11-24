require 'rails_helper'

RSpec.describe "days/edit", :type => :view do
  before(:each) do
    @day = assign(:day, Day.create!(
      :hours_worked => 1.5,
      :day_of_week => 1
    ))
  end

  it "renders the edit day form" do
    render

    assert_select "form[action=?][method=?]", day_path(@day), "post" do

      assert_select "input#day_hours_worked[name=?]", "day[hours_worked]"

      assert_select "input#day_day_of_week[name=?]", "day[day_of_week]"
    end
  end
end
