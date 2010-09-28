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

Feature: All voters
  In order examine the situation
  As a LEO user
  I want to see the paginated list of all voters

  Background:
    Given that I logged in
  
  Scenario: Seeing empty reviewable voters list
    When  I go to the voters index page
    Then  I should see 0 rows with voters in the table
      And I should see "Voter Results 0-0 of 0"
      And I should see "Page 1 of 1"
 
  Scenario: Seeing initial reviewable voters
    Given there are 20 unconfirmed voters
    When  I go to the voters index page
    Then  I should see 15 rows with voters in the table
      And I should see 15 statuses "Unconfirmed"
      And I should see "Voter Results 1-15 of 20"
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
      And I should see "4 / 7" within ".unconfirmed"
  
  
  
