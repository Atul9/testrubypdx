Given /^there (?:is|are) (\d+) meetings?$/ do |count|
  if count == '1'
    @meeting = FactoryGirl.create(:meeting, {description: 'The quick brown fox jumped over the lazy dog'})
  else
    @meetings = []
    count.to_i.times { @meetings << FactoryGirl.create(:meeting) }
  end
end

Given /^the meeting has (\d+) talks$/ do |count|
  @talks = []
  count.to_i.times do 
    @talks << FactoryGirl.create(:talk, meeting_id: @meeting.id)
  end
end

When /^I visit the meeting's view page$/ do 
  visit "/meetings/#{@meeting.id}"
end

Then /^I should see the meeting's (\w+)$/ do |attr|
  expect(page).to have_content(@meeting.send(attr.to_sym))
end 

Then /^I should see information about the talks$/ do 
  expect(page).to have_css '.talk', count: @talks.length
end