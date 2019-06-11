require 'rails_helper'
RSpec.describe "The Commenting Process", type: :feature do 
  before :each do
    @user = create(:user)
    sign_in @user
    @post = create(:post, author: @user)
    @comment = create(:comment, commenter: @user, post: @post)
  end

  it 'creates a comment' do 
    visit root_path
    expect(page).to have_content 'News Feed'
    click_link(" ", href: post_path(@post))
    expect(page).to have_content 'Commnets'
    within('#new_comment') do
    fill_in 'comment_content', with: 'hello new comment to post'
    end
    click_button 'Create Comment'
    expect(page).to have_content 'Comment successful'
  end

  it 'updates a post comment' do
    visit post_path(@post)
    expect(page).to have_content 'Commnets'
    click_link('Edit', href: edit_comment_path(@comment))

    expect(page).to have_content 'Edit Comment'
    within('form') do
      fill_in 'comment_content', with: 'new comment here'
    end
    click_button 'Update Comment'
    expect(page).to have_content 'comment updated'

  end

end
