require 'spec_helper'

feature 'signup form' do
  scenario 'fill and submit form' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(User.first.email).to eq('newuser@gmail.com')
    expect(page).to have_content('Welcome newuser@gmail.com!')
  end

  scenario 'requires a matching confirmation password' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Passwords do not match'
  end

end
