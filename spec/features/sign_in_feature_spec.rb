# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'the signin process', type: :feature do
  before :each do
    @user = create(:user, email: 's@me.com')
  end

  it 'sigin in with correct data' do
    visit new_user_session_path
    expect(page).to have_content 'Log in'

    within('form') do
      fill_in 'Email', with: 's@me.com'
      fill_in 'Password', with: 'foobar'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end

  it 'Sign out when logged in' do
    sign_in @user
    visit root_path
    expect(page).to have_link('Sign out', href: destroy_user_session_path)
    click_link('Sign out', href: destroy_user_session_path)
    expect(page).to have_current_path(new_user_session_path)
  end
end
