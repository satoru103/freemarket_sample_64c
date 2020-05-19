class ItemsController < ApplicationController

  before_action :set_item, only: [:edit, :show]  

  def index
    @item = Item.all.order("created_at DESC").limit(3)
    @items = Item.includes(:pictures).order('created_at DESC')
    @picture = Picture.all
  end

  def new
    @item = Item.new
    @item.pictures.new
    #セレクトボックスの初期値設定
    # @category_parent = Category.where(ancestry: nil)
  end

  # 以下全て、formatはjsonのみ
  # 親カテゴリーが選択された後に動くアクション
  def get_category_children
    #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(id: "#{params[:parent_name]}", ancestry: nil).children
  end
  
  # 子カテゴリーが選択された後に動くアクション
  def get_category_grandchildren
    #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
      if @item.save
        redirect_to root_path,notice: '商品の出品が完了しました'
      else
        @item.pictures.new
        render "new"
      end
  end


  def show
    @comments = @item.comments
    @comment = Comment.new
  end

  def edit
    @item.pictures.new
  end


  def update
    item = Item.find(params[:id])
    if item.update!(item_params)
      redirect_to root_path, notice: "商品の編集が完了しました"
    else
      render :edit
    end
  end

  def purchase
    @item = Item.find(params[:id])
    @item.pictures.new
    card = Card.find_by(user_id: current_user.id)
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    if card.blank?
      #登録された情報がない場合にカード登録画面に移動
      redirect_to new_card_path(@user)
    else
      Payjp.api_key = "sk_test_1547c1078a795141e2ee8623"
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end

  def done
    @item = Item.find(params[:id])
    card = Card.find_by(user_id: current_user.id)
    Payjp.api_key = "sk_test_1547c1078a795141e2ee8623"
    Payjp::Charge.create(
      amount: @item.price, 
      customer: card.customer_id, 
      currency: 'jpy',
    )
    @item = Item.update(buyer_id: 1)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path,notice:'商品を削除しました'
  end

  def edit
    @grandchild_category = @item.category
    @child_category = @grandchild_category.parent
  end


  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to root_path, notice: "商品の編集が完了しました"
    else
      render :edit
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end


  private
  def item_params
    params.require(:item).permit(:category_id,:image_cache,:item_name,:brand,:price,:discription,:status_id,:delivery_charge_id,:area_id,:shipping_date_id,:shipping_method_id,pictures_attributes:[:image, :id, :_destroy]).merge(user_id: current_user.id,seller_id:current_user.id)
  end

end