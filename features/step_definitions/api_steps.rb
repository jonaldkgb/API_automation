Given(/^I want to get the users$/) do
  @request = 'get'
end

=begin
When(/^I send an api GET request$/) do
  if @request == 'get'
    send_get(TestConfig['host'], '/api/users')
  end
end
=end

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


Given(/^I want to post a user$/) do
  @request = 'post'
  @json = create_user
end

When(/^I send an api request$/) do
  case @request.downcase
    when 'get'
      send_get(TestConfig['host'], '/api/users')
    when 'post'
      send_post(TestConfig['host'], '/api/users',@json)
    when 'put'
      send_put(TestConfig['host'], '/api/users/1',@json)
    when 'get_with_parameters'
      send_get_with_parameters(TestConfig['host'], '/api/users', @parameters)
    when 'delete'
      send_delete(TestConfig['host'], '/api/users')
    when 'register'
      send_post(TestConfig['host'], '/api/register',@json)
    else
      raise('Request method not available')
  end
end

Then(/^the user is added$/) do
  p @response.code
  p @response.message
  #expect(@user.address[0].city == JSON.parse(@response.body)['address'][0]['city'])
  expect(JSON.parse(@response.body)['first_name']).to eq(@user.first_name)
  expect(JSON.parse(@response.body)['last_name']).to eq(@user.last_name)
  expect(JSON.parse(@response.body)['address'][0]['city']).to eq(@user.address[0].city)
  expect(JSON.parse(@response.body)['createdAt'].to_s[0..9]).to eq(Time.now.to_s[0..9])
  id = JSON.parse(@response.body)['id']
  p "Your User Id is: #{id}"
end

Given(/^I want to update a user$/) do
  @request = 'put'
  @json = update_user

end

And(/^the user is updated$/) do
  response = JSON.parse(@response.body)
  p response

  # expect(JSON.parse(@response.body)['first_name']).to eq(@user.first_name)
  # expect(JSON.parse(@response.body)['last_name']).to eq(@user.last_name)
  # expect(JSON.parse(@response.body)['address'][0]['house']).to eq(@user.address[0].house)
  # expect(JSON.parse(@response.body)['updatedAt'].to_s[0..9]).to eq(Time.now.to_s[0..9])

  expect(response['first_name']).to eq(@user.first_name)
  expect(response['last_name']).to eq(@user.last_name)
  expect(response['address'][0]['house']).to eq(@user.address[0].house)
  expect(response['updatedAt'].to_s[0..9]).to eq(Time.now.to_s[0..9])
end


Given(/^I want to get the users with parameters$/) do
  @request = 'get_with_parameters'
end

And(/^I want to get "([^"]*)" pages with "([^"]*)" users per page$/) do |page, number_of_users|
  @parameters = "page=#{page}&per_page=#{number_of_users}"
end

And(/^the response displays "([^"]*)" pages with "([^"]*)" users per page$/) do |page, number_of_users|
  response = JSON.parse(@response.body)
  p response['page']
  p response['per_page']
  expect(response['page']).to eq(page.to_i)
  expect(response['per_page']).to eq(number_of_users.to_i)
end


Given(/^I want to delete a user$/) do
  @request = 'delete'
end

Then(/^the user is deleted$/) do
  p @response.code
  p @response.message
  expect(@response.code).to eq('204')
  expect(@response.message).to eq('No Content')
  expect(@response.body).to eq(nil)
end

Given(/^I want to register a user with email (.*) and password (.*)$/) do |email, password|
  @request = 'register'
  @register_user = Credentials.new
  @register_user.email = email
  @register_user.password = password
  @json = JSON.generate(@register_user)
end

Then(/^the following (.*) is returned$/) do |error_message|
  p @response.code
  p @response.message
  expect(JSON.parse(@response.body)['error']).to eq(error_message)
end