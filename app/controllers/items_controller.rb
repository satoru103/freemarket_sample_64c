class ItemsController < ApplicationController
  def index
    @item = Item.all
    @items = Item.includes(:pictures).order('created_at DESC')
    @picture = Picture.all
  end

  def new
    @item = Item.new
    @item.pictures.new
  end

  def create
    @item = Item.new(item_params)
      if @item.save
        redirect_to root_path,notice: '商品の出品が完了しました'
      else
        render :new
      end
  end

  def show
    @item = Item.find(params[:id])
  end

  def purchase
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to root_path,notice:'商品を削除しました'
  end

  def edit
  end

  def update
  end

  private
  def item_params
    params.require(:item).permit(:item_name,:brand,:price,:discription,:status_id,:delivery_charge_id,:area_id,:shipping_date_id,:shipping_method_id,pictures_attributes:[:image]).merge(user_id: current_user.id,seller_id:current_user.id)
  end

end
