require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'with content and commenter and post is valid' do
    comment = build(:comment)
    expect(comment).to be_valid
  end

  it 'without content is invalid' do
    invalid_comment = build(:invalid_post)
    expect(invalid_comment).to_not be_valid
  end

  context 'associations' do
    it { should have_many(:likes).dependent(:destroy) }
    it { should belong_to(:post) }
    it { should belong_to(:commenter) }
  end
end
