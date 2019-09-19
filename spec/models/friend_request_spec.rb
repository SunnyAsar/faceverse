require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  context 'Association' do
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end

  context 'Callbacks' do
    let(:friend_request) do
      user = create(:user)
      friend = create(:user)
      create(:friendship, user: user, friend: friend)
      build(:friend_request, sender: user, receiver: friend)
    end
    it '#validate_frienship invalidate friend request for users that are already friends' do
      expect(friend_request).to_not be_valid
    end
  end
end
