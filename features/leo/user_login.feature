Feature: User login
  In order to access LEO pages
  As a LEO user
  I want to enter the interface

  Background:
    Given the following users
      | login   | email            | password | password_confirmation |
      | correct | correct@osdv.org | correct  | correct               |

  Scenario: Not seeing logout
    When  I am on the login page
    Then  I should not see "Logout"
  
  Scenario: Entering the LEO interface with corrent user name and password
    Given I am on the login page
    When  I fill in "correct" for "user_session[login]"
      And fill in "correct" for "user_session[password]"
      And press "Login"
    Then  I should see "Logout"
  
  Scenario: Trying incorrect user name
    Given I am on the login page
    When  I fill in "incorrect" for "user_session[login]"
      And press "Login"
    Then  I should see "Please login"
  
  Scenario: Trying incorrect password
    Given I am on the login page
    When  I fill in "correct" for "user_session[login]"
      And fill in "incorrect" for "user_session[password]"
      And press "Login"
    Then  I should see "Please login"
