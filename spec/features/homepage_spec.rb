require 'spec_helper'


feature 'homepage' do
  Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

  scenario 'list all bookmarks' do
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end
