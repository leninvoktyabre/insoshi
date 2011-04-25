class AdvertsController < ApplicationController
  
  def index
    @adverts = Advert.find_all_by_status(1)
    
    #@adverts = Advert.active
    @filters = @adverts

    @adverts = @adverts.find_all{|advert| advert.city_id.to_s == cookies[:city_id]} if cookies[:city_id] != nil
    @adverts = @adverts.find_all{|advert| advert.deal_id.to_s == cookies[:deal_id]} if cookies[:deal_id] != nil
    @adverts = @adverts.find_all{|advert| advert.species_id.to_s == cookies[:species_id]} if cookies[:species_id] != nil
    @adverts = @adverts.find_all{|advert| advert.sex_id.to_s == cookies[:sex_id]} if cookies[:sex_id] != nil
    @adverts = @adverts.find_all{|advert| advert.breed_id.to_s == cookies[:breed_id]} if cookies[:breed_id] != nil
    
    @adverts = @adverts.paginate(:page => params[:page],
                                 :per_page => RASTER_PER_PAGE)
 
    #@adverts = @adverts.active(params[:page])
  end
  
  def show
    @advert = Advert.find(params[:id])
  end
  
  def new
    @advert = Advert.new
    @deals = DealType.find(:all)
    @species = SpeciesType.find(:all)
    @sex = SexType.find(:all)
    @breeds = BreedType.find(:all)
  end
  
  def create
    @deals = DealType.find(:all)
    @species = SpeciesType.find(:all)
    @sex = SexType.find(:all)
    @breeds = BreedType.find(:all)
    
    newspecies = params[:advert]['newspecies']
    params[:advert].delete('newspecies')
    
    newbreed = params[:advert]['newbreed']
    params[:advert].delete('newbreed')
    
    @advert = current_person.adverts.build(params[:advert])
    
    @advert.status = 1

    if newspecies.length > 0
      @advert.status = 0
      @new_species = SpeciesType.new({:title => newspecies, :status => 0})
      @new_species.save
      @advert.species_id = @new_species.id
      # todo: letter for admin about a new species
    end
    
    if newbreed.length > 0
      @advert.status = 0
      @new_breed = BreedType.new({:title => newbreed, :status => 0})
      @new_breed.save
      @advert.breed_id = @new_breed.id
      # todo: letter for admin about a new breed
    end
    
    @advert.title = DealType.find_by_id(@advert.deal_id).title + 
      ' ' + SpeciesType.find_by_id(@advert.species_id).title #todo: move into model
    @advert.city_id = current_person.city_id

    respond_to do |format|
      if @advert.save
        Point.add(@advert)
        flash[:success] = "New advertisement successfully created"
        format.html { redirect_to adverts_url }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def edit
    @advert = Advert.find(params[:id])
    @deals = DealType.find(:all)
    @species = SpeciesType.find(:all)
    @sex = SexType.find(:all)
  end
  
  def update
    @advert = Advert.find(params[:id])
    @advert.title = DealType.find_by_id(@advert.deal_id).title + 
      ' ' + SpeciesType.find_by_id(@advert.species_id).title #todo: move into model
    
    respond_to do |format|
      if @advert.update_attributes(params[:advert])
        flash[:success] = 'Advertisement was successfully updated.'
        format.html { redirect_to adverts_url }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @advert = Advert.find(params[:id])
    Point.remove(@advert)
    @advert.destroy

    respond_to do |format|
      flash[:success] = 'Advertisement was successfully destroyed.'
      format.html { redirect_to adverts_url }
    end
  end
  
end
