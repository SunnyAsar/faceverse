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
    let(:user) do
      create(:user_with_relations, friends_count: 5,
                                   sent_friend_requests_count: 2,
                                   received_friend_requests_count: 3)
    end

    it '#friends returns 5 users' do
      expect(user.friends.count).to eq(5)
    end

    it '#friend? returns True for a friend id' do
      friend = user.friends.first
      expect(user.friend?(friend.id)).to be true
    end

    it '#friend? returns False if is not a friend id' do
      not_friend = user.friends_requesting.first
      expect(user.friend?(not_friend.id)).to be false
    end

    it '#friend_requested? returns True for a requested friend id' do
      requested = user.friends_requested.first
      expect(user.friend_requested?(requested.id)).to be true
    end

    it '#friend_requested? returns False if is not a requested friend id' do
      not_requested = create(:user)
      expect(user.friend_requested?(not_requested.id)).to be false
    end

    it '#friend_requesting? returns True for a requesting friend id' do
      requesting = user.friends_requesting.first
      expect(user.friend_requesting?(requesting.id)).to be true
    end

    it '#friend_requesting? returns False if is not a requesting friend id' do
      not_requesting = create(:user)
      expect(user.friend_requesting?(not_requesting.id)).to be false
    end

    it '#request_from returns the friend_request instance that relate the users' do
      requesting = user.friends_requesting.first
      expect(user.request_from(requesting.id)).to be_a FriendRequest
    end

    it '#friend_requests returns users requesting friendship' do
      expect(user.friend_requests).to eq user.friends_requesting
    end
  end
end
