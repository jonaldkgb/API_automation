Feature: API

  @api
  Scenario: api get
    Given I want to get the users
    When I send an api GET request
    Then the response is a success

  @api_get_single_user
  Scenario: Get single user
    Given I want to get a single user
    When I send an api GET single user request
    Then the user details are retrieved

  @api_post
  Scenario: api post
    Given I want to post a user
    When I send an api request
    Then the user is added