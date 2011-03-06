class CitiesController < ApplicationController
  def index
    @cities = City.find(:all)
  end
  
  def show
    @city = City.find(params[:id])
  end
  
  def new
    @city = City.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @city = City.new(params[:city])

    respond_to do |format|
      if @city.save
        flash[:success] = "New city successfully created"
        format.html { redirect_to admin_cities_url }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @city = City.find(params[:id])
  end
  
  def update
    @city = City.find(params[:id])
    
    respond_to do |format|
      if @city.update_attributes(params[:city])
        flash[:success] = 'City was successfully updated.'
        format.html { redirect_to admin_cities_url }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @city = City.find(params[:id])
    @city.destroy

    respond_to do |format|
      flash[:success] = 'City was successfully destroyed.'
      format.html { redirect_to admin_cities_url }
    end
  end
end
