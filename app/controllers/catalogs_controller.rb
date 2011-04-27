class CatalogsController < ApplicationController
  def index
    #raise params.inspect
    @parent = 0
    @categories = Category.find_all_by_parent_id(0)
  end
  
  def show
    #raise params.inspect
    @parent = Category.find(params[:id])
    @categories = Category.find_all_by_parent_id(@parent.id)
    @links = Link.find_all_by_category_id_and_status(@parent.id, 1)
    #raise @categories.inspect
    
  end
end
