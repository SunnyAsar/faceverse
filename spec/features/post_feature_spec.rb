require 'rails_helper'
RSpec.describe "Testing post", type: :feature do
  before :each do
    @user = create(:user)
    sign_in @user
    @post = create(:post, author: @user)
  end

  it 'creates a post from valid content' do
    visit root_path
    expect(page).to have_content 'News Feed'
    within('#new_post') do
      fill_in 'post_content', with: 'hello new post here'
    end
    click_button 'Create Post'
    expect(page).to have_content 'Post created'
  end

  it 'fails to create post with invalid content' do
    visit root_path
    within('#new_post') do
      fill_in 'post_content', with: ' '
    end
    click_button 'Create Post'
    expect(page).to have_content "Content can't be blank"
  end

  # scenario js: true do
    it 'deletes a post' do
      visit root_path
      expect(page).to have_link('Destroy', href: post_path(@post))
      accept_alert do
        click_link('Destroy', href: post_path(@post))
      end
      expect(page).to have_current_path(root_path)
    end
  # end

end
