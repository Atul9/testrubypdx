require 'rails_helper'

RSpec.describe "meetings/edit", type: :view do
  before(:each) do
    @meeting = assign(:meeting, FactoryGirl.create(:meeting))
  end

  it "renders the edit meeting form" do
    render

    assert_select("form[action=?][method=?]", meeting_path(@meeting), "post") do
      assert_select 'input#meeting_date'
      assert_select 'input#meeting_time'
      assert_select 'textarea#meeting_description'
    end
  end
end
