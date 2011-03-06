class DealTypesController < ApplicationController

  def index
    @deals = DealType.find(:all)
  end
  
  def show
    @deal = DealType.find(params[:id])
  end
  
  def new
    @deal = DealType.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @deal = DealType.new(params[:deal_type])

    respond_to do |format|
      if @deal.save
        flash[:success] = "New deal successfully created"
        format.html { redirect_to admin_deal_types_url }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @deal = DealType.find(params[:id])
  end
  
  def update
    @deal = DealType.find(params[:id])
    
    respond_to do |format|
      if @deal.update_attributes(params[:deal_type])
        flash[:success] = 'Deal was successfully updated.'
        format.html { redirect_to admin_deal_types_url }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @deal = DealType.find(params[:id])
    @deal.destroy

    respond_to do |format|
      flash[:success] = 'Deal was successfully destroyed.'
      format.html { redirect_to admin_deal_types_url }
    end
  end
end
