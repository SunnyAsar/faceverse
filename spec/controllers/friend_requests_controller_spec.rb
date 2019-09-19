require 'rails_helper'

RSpec.describe FriendRequestsController, type: :controller do

  before(:each) do
    @user = create(:user)
    sign_in @user
    @friend_request = create(:friend_request)
  end


  describe 'GET #index' do
    it 'resturns the list of friend requests' do
      get :index
      expect(response.successful?)
      expect(assigns(:requests)).to eq(@user.friends_requesting)
    end
  end

  describe "POST #create" do
    it "returns http success" do
     @user2 = create(:user)
      post :create, params: { friend_request: attributes_for(:friend_request, receiver_id: @user) }
      expect(response.successful?)
    end
  end

  describe "DELETE #destroy" do
    it "destroys a friend request" do
    expect{
      delete :destroy, params: {id: @friend_request}
    }.to change(FriendRequest,:count).by(-1)
      expect(response.successful?)
    end
  end

end
