require 'rails_helper'

RSpec.describe 'Views', type: :system do
  scenario 'visits root path' do
    visit root_path
    fill_in "Enter a url", with: "google.com"
    click_on "Create Link"
    expect(page).to have_content 'Link has been created and shortened.'
  end


  scenario "expiring a shortened URL" do
    visit root_path
    fill_in "Enter a url", with: "google.com"
    click_on "Create Link"
    find('a.admin').click
    click_on "Expire"
  end

  scenario "creating with a invalid URL" do
    visit root_path
    fill_in "Enter a url", with: "google"
    click_on "Create Link"
    expect(page).to have_content  "Not a valid url."
  end

  #
  scenario "visiting a shortened URL" do
    visit root_path
    fill_in "Enter a url", with: "google.com"
    click_on "Create Link"
    find('a.admin').click
    find('a.short').click
  end
end
