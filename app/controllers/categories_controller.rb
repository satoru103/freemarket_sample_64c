class CategoriesController < ApplicationController
    
    def index
      @category_parent = Category.where(ancestry: nil)
    end

    def show
      category = Category.find_by(id: params[:id])
      # # 親カテゴリー選択時
      # if category.ancestry == nil
      #   @category_items = Category.find_by(id: params[:id]).indirect_ids
      # # 子カテゴリー選択時


      # 孫カテゴリー選択時
      # elsif category.ancestry.include?("/")
        @category_items = Item.where(category_id: params[:id])

      # end

    end

end
