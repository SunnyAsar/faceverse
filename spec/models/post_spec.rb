# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  it 'with content and author is valid' do
    post = build(:post)
    expect(post).to be_valid
  end

  it 'without content is invalid' do
    post = build(:invalid_post)
    expect(post).not_to eq(true)
  end

  context 'validate associations' do
    it { should belong_to(:author) }
    it { should have_many(:comments) }
  end
end
