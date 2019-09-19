require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'validations' do
    let(:friendship) { build(:friendship, user_id: 1, friend_id: 1)}
    it 'is invalid for self relationship' do
      expect(friendship).to_not be_valid
    end
  end

  context 'callbacks' do
    let(:friendship) { create(:friendship) }
    it { is_expected.to callback(:order_params).before(:create) }
    it { is_expected.to callback(:delete_this_request).after(:create) }
    context '#delte_this_request' do
      let(:request_id) do
        request = create(:friend_request)
        create(:friendship, user: request.receiver, friend: request.sender)
        request.id
      end

      it "friend request don't persist after the frienship creation" do
        expect(FriendRequest).to_not exist(request_id)
      end
    end
    context '#order_params' do
      before(:each) do
        @user1 = create(:user)
        @user2 = create(:user)
        @friendship = create(:friendship, user: @user2, friend: @user1)
      end
      it 'frienship user id equals to the lower id' do
        expect(@friendship.user_id).to eq @user1.id
      end
      it 'frienship user id equals to the higher id' do
        expect(@friendship.friend_id).to eq @user2.id
      end
    end
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
