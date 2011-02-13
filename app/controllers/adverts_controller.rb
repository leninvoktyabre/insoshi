class AdvertsController < ApplicationController
  
  def index
    # @person = Person.find(params[:person_id])
    @adverts = Advert.find(:all)
  end
  
  def show
    @advert = Advert.find(params[:id])
  end
  
  def new
    @advert = Advert.new
  end
  
  def create
    @advert = current_person.adverts.build(params[:advert])
    @advert.title = @advert.deal+' '+@advert.species
    respond_to do |format|
      if @advert.save
        flash[:success] = "New advertisement successfully created"
        format.html { redirect_to adverts_url }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
end
