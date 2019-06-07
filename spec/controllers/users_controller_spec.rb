require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  before(:each) do 
    @user = create(:user)
    sign_in @user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      # expect(assigns(:users)).to eq([@user])
    end
  end

  describe 'GET #show' do
    it 'return the details of a user' do
      get :show, params: {id: @user}
      expect(response.success?)
      expect(assigns(:user)).to eql(@user)
      expect(response).to render_template :show
    end
  end

end
