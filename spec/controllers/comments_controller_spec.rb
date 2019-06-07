require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  before(:each) do 
    @user = create(:user)
    sign_in @user
    @comment = create(:comment,commenter: @user)
    @post = create(:post)
  end

  describe 'POST #create' do
    it "creates a comment" do
    expect{
      post :create, params: {comment: attributes_for(:comment, post_id: @post) }
    }.to change(Comment,:count).by(+1)
    expect(response.successful?)
    end
  end

  describe 'GET #edit' do
    it 'get the edit view' do
      get :edit, params: {id: @comment}
      expect(response.successful?)
      redirect_to :edit
    end
  end

  describe 'PATCH #update' do
    it 'updates a comment ' do
      put :update, params: { id: @comment, comment: attributes_for(:comment, content: "new comment" ) }
      expect(response.successful?)
      @comment.reload
      expect(@comment.content).to eq("new comment")
    end
  end


  describe 'DELETE #destroy' do
    it 'deletes a comment with the passed id' do
      expect{
      delete :destroy, params: {id: @comment}
    }.to change(Comment,:count).by(-1)
    expect(response.successful?)
    end
  end
end
