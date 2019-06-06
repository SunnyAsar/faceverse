require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  before (:each) do
    @user = create(:user)
    sign_in @user
    @post = create(:post, author: @user)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:posts)).to eq(@user.posts)
    end
  end

  describe "GET #show" do 
    it 'return success and the show' do
      get :show, params: {id: @post.to_param}
      expect(response).to have_http_status(:success)
      expect(assigns(:post)).to eq(@post)
      expect(response).to render_template :show
    end
  end

  describe 'POST #Create' do
    it 'creates a new post' do
      post :create, params:  { post: attributes_for(:post, author: @user)}
      expect(response).to redirect_to root_path 
    end
  end

end
