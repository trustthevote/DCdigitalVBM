Feature: Voter review navigation
  In order to review a voter
  As a LEO user
  I want enter the review page and use controls to navigate between voters
  
  Background:
    Given that I logged in

  Scenario: No voters to review
    Given no voters to review
    When  I go to the review page
    Then  I should see "No voters to review"
  
  Scenario: One voter to review
    Given the following voters
      | name | status      |
      | Mike | unconfirmed |
    When  I go to the review page
    Then  I should see "Mike"
      And I should not see "No voters to review"
      And navigation buttons should be disabled

  Scenario: Many voters to review before
    Given the following voters
      | name | status      |
      | Mike | unconfirmed |
      | Jack | unconfirmed |
    When  I go to the review page
    Then  I should see "Jack"
      And button "Next" should be enabled
      And button "Previous" should be disabled
    When  I follow "Next"
    Then  I should see "Mike"
      And button "Next" should be disabled
      And button "Previous" should be enabled

  
  
  
  
  