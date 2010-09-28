Feature: Voter review
  In order to examing the voter record
  As a LEO user
  I want to open it

  Background:
    Given that I logged in

  Scenario: Reviewing unvoted
    Given voter with name "Jack" who hasn't voted yet
    When  I go to voter "Jack" review page
    Then  I should see "Jack"
      And button "Confirm" should be disabled
      And button "Deny" should be disabled
      And button "Unconfirm" should be disabled
      And I should not see the attestation document link
      And I should see voter address
      And I should see voter status
      And I should see the review status "Unconfirmed"
  
  Scenario: Reviewing voted
    Given voter with name "Mike" who voted digitally
    When  I go to voter "Mike" review page
    Then  button "Confirm" should be enabled
      And button "Deny" should be enabled
      And button "Unconfirm" should be disabled
      And I should see the attestation document link
      And I should see voter address
      And I should see voter status  
      And I should see the review status "Unconfirmed"
  
  Scenario: Reviewing confirmed
    Given confirmed voter with name "Mark"
    When  I go to voter "Mark" review page
    Then  I should see confirmation history record
      And button "Confirm" should be disabled
      And button "Deny" should be enabled
      And button "Unconfirm" should be enabled

  
