require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'Associations' do
    it { should belong_to(:liker) }
    it { should belong_to(:likeable) }
  end
end
