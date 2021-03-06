Feature: Vendor views own bids
  As a vendor
  I should be able to view my bids
  So I can see what I have bid on

  Scenario: User does not log in before viewing my bids
    Given I am a user with a verified SAM account

    When I visit my bids page
    Then I should see an "Authorize with GitHub" button

    When I click on the "Authorize with GitHub" button
    Then I should see a "Logout" link

  Scenario: User logs in before viewing my bids
    Given I am a user with a verified SAM account
    And I am signed in
    And there is an open auction
    And I have placed a bid

    When I click on the "My bids" link
    Then I should be on my bids page
    And I should not see bids from other users
    And I should see my bid history
