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
