Feature: Past meetings page

  Scenario: No past meetings
    Given there are no past meetings
    And there is 1 upcoming meeting
    When I visit the 'Past Meetings' page
    Then I should see the text "We haven't had any meetings yet!"
    And I should see a link to the 'Upcoming Meetings' page

  Scenario: Two past meetings
    Given there are 2 past meetings
    And there is 1 upcoming meeting
    When I visit the 'Past Meetings' page
    Then I should see 2 meetings listed