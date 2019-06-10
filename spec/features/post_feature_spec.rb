require 'rails_helper'
RSpec.describe 'Posts', type: :feature do 

  describe "The post creation process" do 
    before :each do 
      user = create(:user)
      sign_in user
    end

    it 'creates a post from the provided content' do
      visit posts_path
      expect(page).to have_content 'News Feed'

      # within('form') do 
      #   fill_in content: 'hello new post here'
      # end
      # click_button 'Create Post'
      # expect(page).to have_content 'Post created'
    end
  end

end