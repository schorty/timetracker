require 'rails_helper'

RSpec.describe "notices/edit", :type => :view do
  before(:each) do
    @notice = assign(:notice, Notice.create!(
      :title => "MyString",
      :content => "MyText",
      :day_id => 1
    ))
  end

  it "renders the edit notice form" do
    render

    assert_select "form[action=?][method=?]", notice_path(@notice), "post" do

      assert_select "input#notice_title[name=?]", "notice[title]"

      assert_select "textarea#notice_content[name=?]", "notice[content]"

      assert_select "input#notice_day_id[name=?]", "notice[day_id]"
    end
  end
end
