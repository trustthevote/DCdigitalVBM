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

  
