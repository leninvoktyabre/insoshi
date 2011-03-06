class AdvertCommentsController < ApplicationController

  def index
    # @adverts = Advert.find(:all)
  end

  def show
    # @advert = Advert.find(params[:id])
  end

  def new
    @comment = AdvertComments.new
  end

  def create
    @advert = Advert.find(params[:advert_id])
    @comment = @advert.advert_comments.build(params[:advert_comment])
    @comment.commenter = current_person
    # raise @comment.inspect
    
    respond_to do |format|
      if @comment.save
        flash[:success] = "New comment successfully created"
        format.html { redirect_to advert_url(@advert) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @advert = Advert.find(params[:advert_id])
    @comment = AdvertComment.find(params[:id])
  end
  
  def update
    @advert = Advert.find(params[:advert_id])
    @comment = AdvertComment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:advert_comment])
        flash[:success] = 'Comment was successfully updated.'
        format.html { redirect_to advert_url(@advert) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @advert = Advert.find(params[:advert_id])
    @comment = AdvertComment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      flash[:success] = 'Comment was successfully destroyed.'
      format.html { redirect_to advert_url(@advert) }
    end
  end

end
