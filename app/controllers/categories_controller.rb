class CategoriesController < ApplicationController
  
  def index
    @categories = Category.find_all_by_category_type(2)
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def new
    if admin?
      @category = Category.new
    end
  end
  
  def create
    if admin?
      @category = Category.new(params[:category])

      respond_to do |format|
        if @category.save
          flash[:success] = "New category successfully created"
          format.html { redirect_to categories_url }
        else
          format.html { render :action => "new" }
        end
      end
    end
  end
  
  def edit
    if admin?
      @category = Category.find(params[:id])
    end
  end
  
  def update
    if admin?
      @category = Category.find(params[:id])

      respond_to do |format|
        if @category.update_attributes(params[:category])
          flash[:success] = 'Category was successfully updated.'
          format.html { redirect_to categories_url }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end
  
  def destroy
    if admin?
      @category = Category.find(params[:id])
      @category.destroy

      respond_to do |format|
        flash[:success] = 'Category was successfully destroyed.'
        format.html { redirect_to categories_url }
      end
    end
  end
  
end
