When(/^I click on the "([^\"]*)" button$/) do |button|
  first(:link_or_button, button).click
end

When(/^I click on the "([^"]+)" link$/) do |label|
  first(:link, label).click
end

Then(/^I should see an? "([^"]+)" link$/) do |link|
  expect(page).to have_selector(:link, link)
end

Then(/^I should not see an? "([^"]+)" link$/) do |link|
  expect(page).to_not have_selector(:link, link)
end

Then(/^I should see an? "([^"]+)" button$/) do |button|
  expect(page).to have_selector(:link_or_button, button, exact: true)
end

Then(/^I should not see an? "([^"]*)" button$/) do |button|
  expect(page).to_not have_selector(:link_or_button, button, exact: true)
end

When(/^I click on the link to the bids$/) do
  bid = WinningBid.new(@auction).find
  bid_amount = Currency.new(bid.amount).to_s
  click_on(bid_amount)
end

When(/^I click on the "Edit" link for the auction$/) do
  within('.auction-title') { first(:link_or_button, "Edit").click }
end

When(/^I click on the update button$/) do
  update_button = I18n.t('helpers.submit.auction.update')
  step("I click on the \"#{update_button}\" button")
end

When(/^I click on the I'm done button$/) do
  button = I18n.t('auctions.show.status.work_in_progress.action')
  step("I click on the \"#{button}\" button")
end

When(/^I click on the add auction link$/) do
  add_link = I18n.t('links_and_buttons.auctions.add')
  step("I click on the \"#{add_link}\" link")
end

When(/^I click on the add customer button$/) do
  add_link = I18n.t('links_and_buttons.customers.add')
  step("I click on the \"#{add_link}\" link")
end

When(/^I click on the create customer button$/) do
  create_button = I18n.t('helpers.submit.create', model: 'Customer')
  step("I click on the \"#{create_button}\" button")
end

When(/^I click on the Download CSV link$/) do
  link = I18n.t('links_and_buttons.users.download_csv')
  step("I click on the \"#{link}\" link")
end

Then(/^I should see a Download CSV link$/) do
  link = I18n.t('links_and_buttons.users.download_csv')
  step("I should see a \"#{link}\" link")
end

When(/^I click on the add skill link$/) do
  add_link = I18n.t('links_and_buttons.skills.add')
  step("I click on the \"#{add_link}\" link")
end

When(/^I click on the create skill button$/) do
  create_button = I18n.t('helpers.submit.create', model: 'Skill')
  step("I click on the \"#{create_button}\" button")
end

When(/^I click on the auction's title$/) do
  click_on(@auction.title)
end

When(/^I click on the name of the first user$/) do
  @user = User.last
  click_on(@user.name)
end

Then(/^I should see the "Edit" link for the auction$/) do
  within('.auction-title') { expect(page).to have_selector(:link, "Edit") }
end

Then(/^I should not see an "Edit" link for the auction$/) do
  within('.auction-title') { expect(page).not_to have_selector(:link, "Edit") }
end
