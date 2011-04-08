class AdBreedsToBreedType < ActiveRecord::Migration
  class BreedType < ActiveRecord::Base  
  end

  class SpeciesType < ActiveRecord::Base  
  end
  
  def self.up 
    species_cat = SpeciesType.find_by_title("Кот")
    species_dog = SpeciesType.find_by_title("Собака")

    breed = BreedType.new(:title => "Сиамский", :status => 1, :species_id => species_cat.id) 
    breed.save!
    breed = BreedType.new(:title => "Чеширский", :status => 1, :species_id => species_cat.id) 
    breed.save!
    breed = BreedType.new(:title => "Бультерьер", :status => 1, :species_id => species_dog.id) 
    breed.save!
    breed = BreedType.new(:title => "Пудель", :status => 1, :species_id => species_dog.id) 
    breed.save!
  end

  def self.down
    BreedType.delete(BreedType.find(:all))
  end
end
