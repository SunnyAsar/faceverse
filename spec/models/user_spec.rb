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
    let(:user) { create(:user) }

    it '#full_name returns a concat of first_name and last_name' do
      expect(user.full_name).to eq([user.first_name, user.last_name].join(' '))
    end

    context 'for relationships' do
      let(:user) do
        create(:user_with_relations, friends_count: 5,
                                     sent_friend_requests_count: 2,
                                     received_friend_requests_count: 3)
      end
      let(:unrelated_user) { create(:user) }
      let(:friend_user) { user.friends.first }
      let(:requested_user) { user.friends_requested.first }
      let(:requesting_user) { user.friends_requesting.first }

      it '#friends returns 5 users' do
        expect(user.friends.count).to eq(5)
      end

      it '#friend? returns True for a friend id' do
        expect(user.friend?(friend_user.id)).to be true
      end

      it '#friend? returns False if is not a friend id' do
        expect(user.friend?(unrelated_user.id)).to be false
      end

      it '#friend_requested? returns True for a requested friend id' do
        expect(user.friend_requested?(requested_user.id)).to be true
      end

      it '#friend_requested? returns False if is not a requested friend id' do
        expect(user.friend_requested?(unrelated_user.id)).to be false
      end

      it '#friend_requesting? returns True for a requesting friend id' do
        expect(user.friend_requesting?(requesting_user.id)).to be true
      end

      it '#friend_requesting? returns False if is not a requesting friend id' do
        expect(user.friend_requesting?(unrelated_user.id)).to be false
      end

      it '#request_from returns the friend_request instance that relate the users' do
        expect(user.request_from(requesting_user.id)).to be_a FriendRequest
      end

      it '#friend_requests returns users requesting friendship' do
        expect(user.friend_requests).to eq user.friends_requesting
      end
    end

    context 'for post and it likes' do
      let(:user) do
        create(:user_with_posts_and_likes)
      end

      it 'user have 3 posts' do
        expect(user.posts.count).to eq(3)
      end
    end
  end
end
