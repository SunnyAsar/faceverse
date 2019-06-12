require 'rails_helper'
RSpec.describe 'The Liking process', type: :feature do
  before :each do
    @user = create(:user)
    @post = create(:post)
    @comment = create(:comment, post: @post)
    sign_in @user
  end

  it 'Like and unlike a post' do
    visit post_path(@post)
    within 'li.post' do
      click_button 'Like'
    end
    expect(page).to have_link('Unlike')
    within 'li.post' do
      click_link 'Unlike'
    end
    expect(page).to have_button('Like')
  end

  it 'Like and unlike a comment' do
    visit post_path(@post)
    within 'li.comment' do
      click_button 'Like'
    end
    expect(page).to have_link('Unlike')
    within 'li.comment' do
      click_link 'Unlike'
    end
    expect(page).to have_button('Like')
  end
end
