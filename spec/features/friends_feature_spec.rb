require 'rails_helper'
RSpec.describe 'The frienship process', type: :feature do
  before :each do
    @user = create(:user_with_relations)
    @friend = @user.friends.first
    @requested = @user.friends_requested.first
    @requesting = @user.friends_requesting.first
    @unrelated = create(:user)
    sign_in @user
  end

  it 'have 1 request notification in the navbar' do
    visit root_path
    requests_link = find_link(href: friend_requests_path)
    expect(requests_link).to have_content 'Request'
    expect(requests_link).to have_content '1'
  end

  it 'accept friend request' do
    visit friend_requests_path
    expect(page).to have_content @requesting.full_name
    click_button 'Accept Friend'
    expect(page).to_not have_content @requesting.full_name
    expect(@requesting).to be_friend(@user)
  end

  it 'reject friend request' do
    visit friend_requests_path
    expect(page).to have_content @requesting.full_name
    accept_alert do
      click_link 'Reject Request'
    end
    expect(page).to_not have_content @requesting.full_name
    expect(@requesting).to_not be_friend(@user)
  end

  it 'show all kind of users in user index' do
    visit users_path
    expect(page).to have_content @unrelated.full_name
    expect(page).to have_button 'Add Friend'
    expect(page).to have_content @friend.full_name
    expect(page).to have_content @requested.full_name
    expect(page).to have_content 'Friend request sent'
    expect(page).to have_content @requesting.full_name
    expect(page).to have_button 'Accept Friend'
    expect(page).to have_link 'Reject Request'
  end

  it 'send friend request to unrelated user' do
    visit users_path
    expect(page).to have_button 'Add Friend'
    click_button 'Add Friend'
    expect(page).to have_content 'Friend request sent'
    expect(page).to_not have_button 'Add Friend'
    expect(@unrelated.request_from(@user)).to_not be_nil
  end
end
