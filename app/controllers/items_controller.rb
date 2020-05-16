class ItemsController < ApplicationController
  def index
    @item = Item.all.order("created_at DESC").limit(3)
    @items = Item.includes(:pictures).order('created_at DESC')
    @picture = Picture.all
    @category_parent = Category.where(ancestry: nil)
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
    @item = Item.find(params[:id])
    @category_parent = Category.where(ancestry: nil)
  end

  def purchase
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path,notice:'商品を削除しました'
  end

  private
  def item_params
    params.require(:item).permit(:category_id,:item_name,:brand,:price,:discription,:status_id,:delivery_charge_id,:area_id,:shipping_date_id,:shipping_method_id,pictures_attributes:[:image]).merge(user_id: current_user.id,seller_id:current_user.id)
  end

end