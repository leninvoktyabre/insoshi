class CategoriesController < ApplicationController
  
  def index
    @categories = Category.find_all_by_parent_id(0)
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def new
    @categories = Category.all
    @category = Category.new
    @parent = 0
  end
  
  def create
    @category = Category.new(params[:category])
    
    parent_id = params[:category]['parent_id'].to_i
    path = params[:category]['title']
    categories = Category.all
    
    categories.map do |cat|
	  if cat.id == parent_id
	    parent_id = cat.parent_id
	    path = "#{cat.title}-#{path}"
	    retry
	  end
    end
    
    #raise @category.inspect
    @category.title_safe = "#{path.to_safe_uri}"
    
    respond_to do |format|
      if @category.save
        flash[:success] = "New category successfully created"
        format.html { redirect_to admin_settings_url(:anchor => "tCatalog") }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @categories = Category.all
    @category = Category.find(params[:id])
    @parent = @category.parent_id
  end
  
  def update
    @category = Category.find(params[:id])
    @category.title_safe = params[:category]['title'].to_safe_uri
    
    respond_to do |format|
      if @category.update_attributes(params[:category])
        flash[:success] = 'Category was successfully updated.'
        format.html { redirect_to admin_settings_url(:anchor => "tCatalog") }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      flash[:success] = 'Category was successfully destroyed.'
      format.html { redirect_to admin_settings_url(:anchor => "tCatalog") }
      end
  end
  
  def get_subcat
    @categories = Category.all
    @parent = params[:parent]
    
    if @parent.to_i > 0
      render :partial => 'subcat'
    else
      render :nothing => true
    end
    
  end
  
end
