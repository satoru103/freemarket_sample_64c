require 'rails_helper'

RSpec.describe UsersController, type: controller do

  describe 'GET #show' do

    # インスタンス変数の正常確認
    it "@userに正しい値が入っているか" do
      user = crete(:user)
      get :show, params: { id: user }
      expect(assigns(:user)).to eq user
    end

    # show.html.hamlへの正常移動確認
    it "show.html.hamlに移動すること" do
      user = create(:user)
      get :show, params: { id: user }
      expect(response).to render_template :show
    end
  end

end
