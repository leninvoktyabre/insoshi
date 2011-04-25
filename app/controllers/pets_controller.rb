class PetsController < ApplicationController
   
  def index
    #@person = Person.find(params[:person_id])
    @pets = Pet.find_all_by_status(Pet.status_list['active']).paginate :page => params[:page]
  end
  
  def show
    @pets = Pet.find_all_by_person_id(params[:id]).paginate :page => params[:page]
    @pet = Pet.find(params[:id])
  end
  
  def new
    @pet = Pet.new
    @species = SpeciesType.find(:all)
    @sex = SexType.find(:all)
    @breeds = BreedType.find(:all)
  end
  
  def create
    @species = SpeciesType.find(:all)
    @sex = SexType.find(:all)
    @breeds = BreedType.find(:all)
   
    @pet = Pet.new(params[:pet])
    @pet.person = current_person
    @pet.status = 1
    
    if params[:pet][:species_id].to_i == 0
      @pet.status = 0
      # todo: sand email to admin about new species and new breed
      
      new_species = SpeciesType.new({:title => params[:pet][:new_species], :status => 0})
      new_species.save     
      BreedType.new({:title => params[:pet][:new_breed], :species_id => new_species.id, :status => 0}).save
    end
    
    respond_to do |format|
      if @pet.save
        Point.add(@pet)
        flash[:success] = "New pets profile successfully created"
        format.html { redirect_to person_url(current_person, :anchor => 'tPets') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @pet = Pet.find(params[:id])
    @species = SpeciesType.find(:all)
    @sex = SexType.find(:all)
    @breeds = BreedType.find(:all)
  end
  
  def update
    @pet = Pet.find(params[:id])
    @species = SpeciesType.find(:all)
    @sex = SexType.find(:all)
    @breeds = BreedType.find(:all)
    
    params[:pet].delete('newspecies')
    params[:pet].delete('newbreed')
    
    respond_to do |format|
      if @pet.update_attributes(params[:pet])
        flash[:success] = 'Category was successfully updated.'
        format.html { redirect_to person_url(current_person, :anchor => 'tPets') }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @pet = Pet.find(params[:id])
    Rating.remove(@pet)
    Point.remove(@pet)
    @pet.destroy

    respond_to do |format|
      flash[:success] = 'Pet was successfully destroyed.'
      format.html { redirect_to person_url(current_person, :anchor => 'tPets') }
      end
  end
  
  def get_breed
    species_id = params[:species_id].to_i
    @breeds = BreedType.find_all_by_species_id species_id
    if params[:id]
      @pet = Pet.find(params[:id])
    else
      @pet = Pet.new
    end
    
    if species_id > 0
      render :partial => 'breed'
    else
      render :nothing => true
    end
    
  end
  
end
