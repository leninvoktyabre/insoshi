class LinksController < ApplicationController
  
  def index
    # @category = Category.find(params[:category_id])
  end
  
  def new
    @category = Category.find(params[:category_id])
    @link = Link.new
  end
  
  def create
    @category = Category.find(params[:category_id])
    @link = Link.new(params[:link])
    @link.person = current_person
    @link.category_id = @category.id
    @link.status = 1
    # raise @comment.inspect
    
    respond_to do |format|
      if @link.save
        Point.add(@link)

        flash[:success] = "New link successfully created"
        format.html { redirect_to catalog_url(@category) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @category = Category.find(params[:category_id])
    @link = Link.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:category_id])
    @link = Link.find(params[:id])

    respond_to do |format|
      if @link.update_attributes(params[:link])
        flash[:success] = 'Link was successfully updated.'
        format.html { redirect_to catalog_url(@category) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @category = Category.find(params[:category_id])
    @link = Link.find(params[:id])
    Point.remove(@link)
    @link.destroy

    respond_to do |format|
      flash[:success] = 'Link was successfully destroyed.'
      format.html { redirect_to catalog_url(@category) }
    end
  end
  
end
