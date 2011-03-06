class BreedTypesController < ApplicationController
  def index
    @breeds = BreedType.find(:all)
    @species = BreedType.find(:all)
  end
  
  def show
    @breed = BreedType.find(params[:id])
  end
  
  def new
    @breed = BreedType.new
    @species = SpeciesType.find(:all)
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @breed = BreedType.new(params[:breed_type])

    respond_to do |format|
      if @breed.save
        flash[:success] = "New breed successfully created"
        format.html { redirect_to admin_breed_types_url }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @breed = BreedType.find(params[:id])
    @species = SpeciesType.find(:all)
  end
  
  def update
    @breed = BreedType.find(params[:id])
    
    respond_to do |format|
      if @breed.update_attributes(params[:breed_type])
        flash[:success] = 'Breed was successfully updated.'
        format.html { redirect_to admin_breed_types_url }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @breed = BreedType.find(params[:id])
    @breed.destroy

    respond_to do |format|
      flash[:success] = 'Breed was successfully destroyed.'
      format.html { redirect_to admin_breed_types_url }
    end
  end
end
