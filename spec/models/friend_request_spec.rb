require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  context 'callbacks' do
    let(:friend_request) { create(:friend_request) }
    it { is_expected.to callback(:order_params).before(:create) }
  end

  context 'Association' do
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end
end
