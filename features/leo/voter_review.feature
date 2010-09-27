Feature: Voter review
  In order to review a voter
  As a LEO user
  I want to use controls

  Background:
    Given that I logged in

  Scenario: Reviewing unvoted
    Given voter with name "Jack" who hasn't voted yet
    When  I go to voter "Jack" review page
    Then  I should see "Jack"
      And button "Confirm" should be disabled
      And button "Deny" should be disabled
      And I should not see the attestation document link
  
  Scenario: Reviewing voted
    Given voter with name "Mike" who voted digitally
    When  I go to voter "Mike" review page
    Then  button "Confirm" should be enabled
      And button "Deny" should be enabled
      And I should see the attestation document link
  

  
  
  
  
  
  
  
  
  