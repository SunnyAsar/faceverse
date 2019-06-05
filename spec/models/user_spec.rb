require 'rails_helper'

RSpec.describe User, type: :model do
  context 'testing Associations' do
    it { should have_many(:posts).dependent(:destroy)}
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one(:profile).dependent(:destroy) }
  end

  context 'friend_requests' do
    it { should have_many(:friends_requested).through(:sent_requests) }
    it { should have_many(:friends_requesting).through(:received_requests)}
  end

  context 'friendship' do
    it { should have_many(:direct_friends).through(:direct_friendships) }
    it { should have_many(:inverse_friends).through(:inverse_friendships)}
  end

  describe 'public instance methods' do
    let(:user) { create(:user_with_friends) }
  
    context 'respond to its instance methods' do
      describe 'This user should have friends' do 
       it { expect(user.friends.count).to eq(3) }
      end
    end
  end
end
