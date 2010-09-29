Feature: User logout
  In order to leave the application
  As a LEO user
  I want to log out

  Scenario: Logging out
    Given that I logged in
    When  I follow "Logout"
    Then  I should see "Password"
  
