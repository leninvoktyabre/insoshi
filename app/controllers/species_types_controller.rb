class SpeciesTypesController < ApplicationController
  def index
    @species = SpeciesType.find(:all)
  end
  
  def show
    @spec = SpeciesType.find(params[:id])
  end
  
  def new
    @spec = SpeciesType.new
    
    respond_to do |format|
      format.html # new.html.erb
    end
  end
  
  def create
    @spec = SpeciesType.new(params[:species_type])

    respond_to do |format|
      if @spec.save
        flash[:success] = "New species successfully created"
        format.html { redirect_to admin_species_types_url }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @spec = SpeciesType.find(params[:id])
  end
  
  def update
    @spec = SpeciesType.find(params[:id])
    
    respond_to do |format|
      if @spec.update_attributes(params[:species_type])
        flash[:success] = 'Species was successfully updated.'
        format.html { redirect_to admin_species_types_url }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @spec = SpeciesType.find(params[:id])
    @spec.destroy

    respond_to do |format|
      flash[:success] = 'Species was successfully destroyed.'
      format.html { redirect_to admin_species_types_url }
    end
  end
end
