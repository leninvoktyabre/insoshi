class AddSpeciesToSpeciesType < ActiveRecord::Migration
  class SpeciesType < ActiveRecord::Base  
  end

  def self.up   
    species = SpeciesType.new(:title => "Кот", :status => 1) 
    species.save!
    species = SpeciesType.new(:title => "Собака", :status => 1) 
    species.save!
    species = SpeciesType.new(:title => "Крокодил", :status => 0) 
    species.save!  
  end
  say "species add"
  def self.down
    SpeciesType.delete(SpeciesType.find(:all))
  end  
end
