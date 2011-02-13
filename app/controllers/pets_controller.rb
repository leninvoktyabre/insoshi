class PetsController < ApplicationController
  
  def show
    @pet = Pet.find(params[:id])
  end
  
  def index
    @person = Person.find(params[:person_id])
    @pets = @person.pets.paginate :page => params[:page]
  end
  
  def new
    @pet = Pet.new
  end
  
  def create
    @pet = current_person.pets.build(params[:pet])
    respond_to do |format|
      if @pet.save
        flash[:success] = "New pets profile successfully created"
        format.html { redirect_to pets_url(@pet) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
end
