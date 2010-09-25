Feature: Review
  In order to review a voter
  As a LEO user
  I want enter the review page and use controls to change attestation status
  
  Background:
    Given that I logged in
    And the following registrations
      | name | status      | deny_comment | voted |
      | Mark | unconfirmed |              | true  |
      | Jack | confirmed   |              | true  |
      | Mary | deined      | late         | false |
      | Leon | unconfirmed |              | false |

  Scenario: Entering the review page
    When I go to voter review page
    Then 
  
  
  
  
  