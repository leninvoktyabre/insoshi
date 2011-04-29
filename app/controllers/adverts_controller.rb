class AdvertsController < ApplicationController
  
  def index
    @adverts = Advert.find(:all, :order => 'created_at DESC')
    
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
    #raise params.inspect    
    @advert = current_person.adverts.build(params[:advert])
    
    @advert.status = 1

    if params[:advert][:species_id].to_i == 0
      @advert.status = 0
      @advert.species_id = 0
      @advert.breed_id = 0
      # todo: sand email to admin about new species and new breed
      
      new_species = SpeciesType.new({:title => params[:advert][:new_species], :status => 0})
      new_species.save     
      BreedType.new({:title => params[:advert][:new_breed], :species_id => new_species.id, :status => 0}).save

    end
    
    species = @advert.species_id != 0 ? SpeciesType.find_by_id(@advert.species_id).title : params[:advert][:new_species]
    @advert.title = DealType.find_by_id(@advert.deal_id).title + 
      ' ' + species #todo: move into model
      
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
  
  def get_breed
    species_id = params[:species_id].to_i
    @breeds = BreedType.find_all_by_species_id species_id
    if params[:id]
      @advert = Advert.find(params[:id])
    else
      @advert = Advert.new
    end
    
    if species_id > 0
      render :partial => 'breed'
    else
      render :nothing => true
    end
    
  end
  
end
