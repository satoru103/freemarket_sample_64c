require 'rails_helper'

RSpec.describe AddressesController, type: controller do
  describe 'GET #new' do
    it "new.html.hamlに移動すること" do
      get :new
      expect(response).to render_template :new
    end

  end


  describe 'POST #create' do
    it "@addressに正しい値が入っているか" do
      addres = create(:address)
    end

  end

  describe 'GET #edit' do
    it "@userに正しい値が入っていること" do
      user = create(:user)
      get :edit, params: { id: user }
    end

    it "edit.html.hamlに移行すること" do
    end
  end

  describe 'PATCH #update' do
    it "" do
    end
  end

end

