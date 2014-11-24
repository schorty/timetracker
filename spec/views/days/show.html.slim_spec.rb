require 'rails_helper'

RSpec.describe "days/show", :type => :view do
  before(:each) do
    @day = assign(:day, Day.create!(
      :hours_worked => 1.5,
      :day_of_week => 1,
      :business => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
