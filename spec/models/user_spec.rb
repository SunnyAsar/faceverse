require 'rails_helper'

RSpec.describe User, type: :model do

  context 'field validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  context 'testing Associations' do
    it { should have_many(:posts).dependent(:destroy)}
    it { should have_many(:comments).dependent(:destroy) }
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
    context 'respond to its methods' do
      it { expect(user).to respond_to(:friends) }
      it { expect(user).to respond_to(:send_friend_request) }
      it { expect(user).to respond_to(:friend_requests) }
    end
  end
end
