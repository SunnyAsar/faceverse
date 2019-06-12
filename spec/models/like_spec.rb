require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'Associations' do
    it { should belong_to(:liker) }
    it { should belong_to(:likeable) }
  end

  context 'Scope #for' do
    let(:comment_like) { create(:like, :for_comment) }
    let(:post_like) { create(:like, :for_post) }

    it 'Return the like instance for post' do
      expect(Like.for(post_like.likeable.id, 'Post')).to eq post_like
    end

    it 'Return the like instance for comment' do
      expect(Like.for(comment_like.likeable.id, 'Comment')).to eq comment_like
    end
  end
end
