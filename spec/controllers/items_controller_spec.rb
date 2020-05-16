require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe 'GET #index' do

    # OK
    it "@itemに正しい値が入っているか" do
      item = build(:item)
      get :index
      expect(assigns(:item)).to eq item
    end

    # OK
    it "@itemsに正しい値が入っているか" do
      items = create_list(:item, 3)
      get :index
      expect(assigns(:items)).to match(:items)
    end

    # OK
    it "@pictureに正しい値が入っているか" do
      picture = build(:picture)
      get :index
      expect(assigns(picture)).to eq picture
    end

    # OK
    it "index.html.hamlへの移行が正常に行えているか" do
      get :index
      expect(response).to render_template :index
    end

  end

  describe 'GET #new' do

    # OK
    it "@itemに正しい値が入っているか" do
      item = create(:item)
      get :new
      expect(assigns(:item)).to eq item
    end

    # OK
    it "new.html.hamlへの移動が正常に行えているか" do
      get :new
      expect(response).to render_template :new
    end

  end

  describe 'POST #create' do

    # SOSO...
    it "@itemに正しい値が入っているか" do
      item = create(:item)
      post :create
      expect(assigns(:item)).to eq :item
    end

    # SOSO...
    it "createされた時にredirectしてrootパスに戻るか" do
      item = create(:item)
      post :create
      expect(response).to render_template :create
    end

  end

  describe 'GET #show' do

    # OK
    it "@itemに正しい値が入っているか" do
      item = create(:item)
      get :show, params: { id: item }
      expect(assigns(:item)).to 
    end

    # OK
    it "show.html.hamlへの移動が正常に行えているか" do
      get :show
      expect(response).to render_template :show
    end
  end

  descrice 'DELETE #destroy' do

    # OK
    it "@itemに正しい値が入っているか" do
      item = create(:item)
      delete :destroy, params: { id: item }
      expect(assigns(item)).to eq item
    end

    # OK
    it "destroyアクションを行えており、それに応じてrootパスに戻れているか" do
      delete :destroy
      expect(response).to render_template :destroy
    end
  end

end
