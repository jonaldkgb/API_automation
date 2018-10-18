Given(/^I want to get the users$/) do
  @request = 'get'
end

When(/^I send an api GET request$/) do
  if @request == 'get'
    send_get(TestConfig['host'], '/api/users')
  end
end

Then(/^the response is a success$/) do
  p @response.code
  p @response.message
  expect(@response.code).to eq('200')
  expect(@response.message).to eq('OK')

end


Given(/^I want to get a single user$/) do
  @request = 'get'
end

When(/^I send an api GET single user request$/) do
  if @request == 'get'
    send_get(TestConfig['host'], '/api/users/1')
  end
end

Then(/^the user details are retrieved$/) do
  p @response.code
  p @response.message
  @user_id = JSON.parse(@response.body)['data']['id'].to_s
  #@user_id = JSON.parse(@response.body)['data'][0].to_s
  @user_name = (JSON.parse(@response.body)['data']['first_name'])+" "+(JSON.parse(@response.body)['data']['last_name'])
  p "User " + @user_id  + " - " + @user_name
  expect(@response.code).to eq('200')
  expect(@response.message).to eq('OK')
end

