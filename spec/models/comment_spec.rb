require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:commenter) }
  end

  context 'associations' do
    it { should have_many(:likes).dependent(:destroy) }
    it { should belong_to(:post) }
    it { should belong_to(:commenter) }
  end

end
