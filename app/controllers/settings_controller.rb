class SettingsController < ApplicationController
  def index
    @cities = City.find(:all)
    @deals = DealType.find(:all)
    @species = SpeciesType.find(:all)
    @sex = SexType.find(:all)
    @breeds = BreedType.find(:all)
    
    @categories = Category.find :all
  end
end
