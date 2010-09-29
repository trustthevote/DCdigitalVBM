Feature: Voter review navigation
  In order to review a voter
  As a LEO user
  I want enter the review page and use controls to navigate between voters
  
  Background:
    Given that I logged in

  Scenario: Finished reviewing
    Given no voters to review
    When  I go to the review page
    Then  I should see "Finished"
  
  Scenario: One voter to review
    Given the following voters
      | name | voted_digitally |
      | Mike | true            |
    When  I go to the review page
    Then  I should see "Mike"
