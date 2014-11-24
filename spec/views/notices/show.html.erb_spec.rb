require 'rails_helper'

RSpec.describe "notices/show", :type => :view do
  before(:each) do
    @notice = assign(:notice, Notice.create!(
      :title => "Title",
      :content => "MyText",
      :day_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
