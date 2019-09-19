require 'rails_helper'
RSpec.describe FriendshipsController, type: :controller do

  before(:each) do
    @user = create(:user)
    sign_in @user
    @friendship = create(:friendship, user: @user)
  end

  describe 'POST #create' do
    context 'for successful and failed friendship' do
      it 'creates a friendship' do
        post :create, params: { friendship: attributes_for(:friendship, friend_id: @user) }
        expect(response.successful?)
      end

      it 'should not create a friendship' do
        post :create, params: { friendship: attributes_for(:friendship, user: @user, friend_id:@user)}
        expect(response).to_not eq(:success)
      end
    end
  end





end
