require 'rails_helper'

RSpec.describe User, type: :model do

  # let (:user) { User.new(first_name:'j',email:'p@m.com',password:'foobar',password_confirmation:'foobar').save}
  # it 'validates first name' do 
  #   expect(user).not_to eq(true)
  # end

  it 'validates last name' do 
    user = User.new(last_name:'q',email:'p@m.com',password:'foobar',password_confirmation:'foobar').save
    expect(user).not_to eq(true)
  end

  context 'field validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  context 'testing Associations' do
    it { should have_many(:posts).dependent(:destroy)}
    it { should have_many(:comments).dependent(:destroy) }
  end

  context 'many to many' do
    it { should have_many(:friends_requested).through(:sent_requests) }
    it { should have_many(:friends_requesting).through(:received_requests)}
  end
  
end
