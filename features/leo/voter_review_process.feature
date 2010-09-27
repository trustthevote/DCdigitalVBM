Feature: Voter review process
  In order to review a voter
  As a LEO user
  I want to use controls

  Background:
    Given that I logged in
    And   voter with name "Mike" who voted digitally
    And   I go to voter "Mike" review page
  
  Scenario: Confirming
    When  I follow "Confirm"
    Then  I should see "Mike"
      And I should see the review status "Confirmed"
      And I should not see status manipulation buttons
      And I should see the "Change Status" button
      # And I should see confirmation history record

  Scenario: Denying
    When  I follow "Deny"
      And I set deny reason to "My reason"
      And I press "Submit"
    Then  I should see the review status "Denied"
      And I should not see status manipulation buttons
      And I should see the "Change Status" button
      # And I should see denial history record

  Scenario: Changing status
    Given I follow "Confirm"
    When  I follow "Change Status"
      And I follow "Deny"
      And I set deny reason to "New reason"
      And I press "Submit"
    Then  I should see the review status "Denied"
      And I should not see status manipulation buttons
      And I should see the "Change Status" button
      # And I should see confirmation history record
      # And I should see denial history record
