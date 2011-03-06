class SexTypesController < ApplicationController
  def index
    @sex = SexType.find(:all)
  end
  
  def show
    @sex = SexType.find(params[:id])
  end
  
  def new
    @sex = SexType.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @sex = SexType.new(params[:sex_type])

    respond_to do |format|
      if @sex.save
        flash[:success] = "New sex successfully created"
        format.html { redirect_to admin_sex_types_url }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @sex = SexType.find(params[:id])
  end
  
  def update
    @sex = SexType.find(params[:id])
    
    respond_to do |format|
      if @sex.update_attributes(params[:sex_type])
        flash[:success] = 'Sex was successfully updated.'
        format.html { redirect_to admin_sex_types_url }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @sex = SexType.find(params[:id])
    @sex.destroy

    respond_to do |format|
      flash[:success] = 'Sex was successfully destroyed.'
      format.html { redirect_to admin_sex_types_url }
    end
  end
end
