Given /^there are no meetings$/ do
  Meeting.count == 0
end

When /^I visit the "Create a Meeting" page$/ do 
  click_link 'Add Meeting'
end

When /^I submit the form to create a meeting$/ do 
  within '#new_meeting' do 
    fill_in 'meeting_date', with: Date.today.to_s
    click_button 'Create Meeting'
  end
end

When /^I submit the '\#new_meeting' form with the following attributes:$/  do |table|
  data = table.hashes.first

  within '#new_meeting' do 
    data.each do |key, value|
      fill_in "meeting[#{key}]", with: value
    end

    click_button 'Create Meeting'
  end
end

When /^I click the "([^"]*)" link$/ do |text|
  click_link text
end

Then /^there should be (\d+) meetings?$/ do |count|
  expect(Meeting.count).to eql count.to_i
end

Then /^I should be on the new meeting's view page$/ do 
  expect(current_path).to eql "/meetings/#{Meeting.last.id}"
end

Then /^I should see the meeting creation form$/ do 
  within '#admin_panel' do 
    expect(page).to have_css '#new_meeting'
  end
end

Then /^I should have the option to create a talk$/ do 
  pending
  expect(page).to have_link 'Add a talk'
end

Then /^I should see a message that the meeting has been created$/ do
  expect(page).to have_content 'Meeting was successfully created'
end

Then /^I should see a message that the meeting was invalid$/ do 
  expect(page).to have_content 'Meeting invalid.'
end