require 'rails_helper'

RSpec.describe CardsController, type: controller do
  describe 'GET #new' do
    it "new.html.hamlへの移行" do
      get :new
      expect(response).to render_template :new
    end
  end
end