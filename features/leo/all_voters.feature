Feature: All voters
  In order examine the situation
  As a LEO user
  I want to see the paginated list of all voters

  Background:
    Given that I logged in
  
  Scenario: Seeing empty reviewable voters list
    When  I go to the voters index page
    Then  I should see 0 rows with voters in the table
      And I should see "There are no voter records to review at the moment"
 
  Scenario: Seeing initial reviewable voters
    Given there are 30 unconfirmed voters
    When  I go to the voters index page
    Then  I should see 25 rows with voters in the table
      And I should see 25 statuses "Unconfirmed"
      And I should see "Voter Results 1-25 of 30"
      And I should see "Page 1 of 2"

  Scenario: Status panel
    Given there are 5 registrations
      And there are 2 unreviewed voters
      And there are 4 unconfirmed voters
      And there are 2 confirmed voters
      And there are 1 denied voters
    When  I go to the voters index page
    Then  I should see "Status panel"
      And I should see "9 / 14" within ".returned"
      And I should see "7 / 9" within ".reviewed"
      And I should see "2 / 7" within ".confirmed"
      And I should see "1 / 7" within ".denied"
  
  
  
