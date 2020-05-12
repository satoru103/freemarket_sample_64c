class CategoriesController < ApplicationController
    
    def index
      @category_parent = Category.where(ancestry: nil)
    end

    def show
      @category_items = 
    end

end
