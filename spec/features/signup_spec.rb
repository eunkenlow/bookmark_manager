require 'spec_helper'

feature 'signup form' do
  scenario 'fill and submit form' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(User.first.email).to eq('newuser@gmail.com')
    expect(page).to have_content('Welcome newuser@gmail.com!')
  end

  scenario 'requires a matching confirmation password' do
    # again it's questionable whether we should be testing the model at this
    # level.  We are mixing integration tests with feature tests.
    # However, it's convenient for our purposes.
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
  end

end
