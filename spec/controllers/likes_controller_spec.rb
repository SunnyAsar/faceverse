require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  before(:each) do
    @user = create(:user)
    @like = create(:like, liker:@user)
    sign_in @user
  end

  describe 'POST #create' do
    it 'creates a new like' do
      post :create, params: {like: attributes_for(:like,likeable_id: @post, likeable_type: @post )}
      expect(response.successful?)
    end
  end

  describe "DELETE #destroy" do
    it 'destroys a like' do
      expect{
      delete :destroy, params: {id: @like}
    }.to change(Like, :count).by(-1)
      expect(response.successful?)
    end
  end





end
