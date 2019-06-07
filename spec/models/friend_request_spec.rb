require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  context 'Association' do
    it { should belong_to(:sender) }
    it { should belong_to(:receiver) }
  end
end
