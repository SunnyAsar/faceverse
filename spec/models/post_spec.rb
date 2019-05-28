# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it 'expects post to be valid' do
    post = Post.create!(content: 'the test post', author_id: user.id).save
    expect(post).to eq(true)
  end

  it 'expects author to be invalid' do
    post = Post.new(content: 'the test post').save
    expect(post).to eq(false)
  end

  it 'expects content to be invalid' do
    post = Post.new(author_id: user.id).save
    expect(post).not_to eq(true)
  end

  it 'expects post to be stored' do
    post = Post.new(content: 'the test post', author_id: user.id).save
    expect(Post.count).to eq(1)
  end

  context 'validate associations' do
    it { should belong_to(:author) }
    it { should have_many(:comments) }
  end
end
