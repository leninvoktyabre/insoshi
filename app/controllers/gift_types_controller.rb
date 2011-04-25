class GiftTypesController < ApplicationController
  def index
    @gifts = GiftType.find(:all)
  end
  
  def show
    @gift = GiftType.find(params[:id])
  end
  
  def new
    @gift = GiftType.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @gift = GiftType.new(params[:gift_type])

    respond_to do |format|
      if @gift.save
        flash[:success] = "New gift successfully created"
        format.html { redirect_to admin_gift_types_url }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @gift = GiftType.find(params[:id])
  end
  
  def update
    @gift = GiftType.find(params[:id])
    
    respond_to do |format|
      if @gift.update_attributes(params[:gift_type])
        flash[:success] = 'Gift was successfully updated.'
        format.html { redirect_to admin_gift_types_url }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @gift = GiftType.find(params[:id])
    @gift.destroy

    respond_to do |format|
      flash[:success] = 'Gift was successfully destroyed.'
      format.html { redirect_to admin_gift_types_url }
    end
  end
end
