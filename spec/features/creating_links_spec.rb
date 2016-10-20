require 'spec_helper'

feature 'Create link' do
  scenario 'user submits form' do
    visit '/links/new'
    fill_in('title', with: 'Kitten Academy')
    fill_in('url', with: 'http://www.kittenacademy.com')
    click_button('Add')
    find_link('kittenacademy').visible?
  end
end
