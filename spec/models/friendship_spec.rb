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
  end

  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
