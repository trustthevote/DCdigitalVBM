# Version: OSDV Public License 1.2
# The contents of this file are subject to the OSDV Public License
# Version 1.2 (the "License"); you may not use this file except in
# compliance with the License. You may obtain a copy of the License at
# http://www.osdv.org/license/
# Software distributed under the License is distributed on an "AS IS"
# basis, WITHOUT WARRANTY OF ANY KIND, either express or implied.
# See the License for the specific language governing rights and limitations
# under the License.
# 
# The Original Code is:
# 	TTV UOCAVA Ballot Portal.
# The Initial Developer of the Original Code is:
# 	Open Source Digital Voting Foundation.
# Portions created by Open Source Digital Voting Foundation are Copyright (C) 2010.
# All Rights Reserved.
# 
# Contributors: Paul Stenbjorn, Aleksey Gureiev, Robin Bahr,
# Thomas Gaskin, Sean Durham, John Sebes.

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
      | name | voted_digitally |
      | Mike | true            |
    When  I go to the review page
    Then  I should see "Mike"
      And I should not see "No voters to review"
      And navigation buttons should be disabled

  Scenario: Many voters to review before
    Given the following voters
      | name | voted_digitally |
      | Mike | true            |
      | Jack | true            |
    When  I go to the review page
    Then  I should see "Jack"
      And button "Next" should be enabled
      And button "Previous" should be disabled
    When  I follow "Next"
    Then  I should see "Mike"
      And button "Next" should be disabled
      And button "Previous" should be enabled
