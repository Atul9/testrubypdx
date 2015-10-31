Given /^there are no users$/ do 
  User.count == 0
end

Given /^there are (\d+) users$/ do |count|
  FactoryGirl.create_list(:user, count.to_i)
end

When /^I visit the "Create a User" page$/ do 
  visit '/users/new'
end

When /^I submit the creation form with valid information$/ do 
  within '#new_user' do 
    fill_in 'user_name', with: 'foobarbaz'
    fill_in 'user_password', with: 'foobarbaz'
    fill_in 'user_password_confirmation', with: 'foobarbaz'
    fill_in 'user_email', with: 'foobar@baz.com'
    click_button 'Create User'
  end
end

Then /^there should be (\d+) users?$/ do |num|
  expect(User.count).to eql num.to_i
end

Then /^I should not see the user creation form$/ do 
  expect(page).not_to have_selector '#new_user'
end