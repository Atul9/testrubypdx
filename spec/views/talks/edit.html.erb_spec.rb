require 'rails_helper'

RSpec.describe "talks/edit", type: :view do
  before(:each) do
    @talk = assign(:talk, Talk.create!(
      :title => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit talk form" do
    render

    assert_select "form[action=?][method=?]", talk_path(@talk), "post" do

      assert_select "input#talk_title[name=?]", "talk[title]"

      assert_select "select#talk_speaker_id[name=?]", "talk[speaker_id]"

      assert_select "select#talk_meeting_id[name=?]", "talk[meeting_id]"

      assert_select "textarea#talk_description[name=?]", "talk[description]"
    end
  end
end
