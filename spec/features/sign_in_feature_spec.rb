require 'rails_helper'
RSpec.describe "the signin process", type: :feature do
  before :each do
    create(:user, email:'s@me.com', password: 'foobar')
  end

    it "sigin in with correct data" do
      visit new_user_session_path
    expect(page).to have_content 'Log in'

    within('form') do 
      fill_in "Email", with: 's@me.com'
      fill_in "Password", with: 'foobar'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    end


  
end
