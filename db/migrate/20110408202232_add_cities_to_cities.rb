class AddCitiesToCities < ActiveRecord::Migration
  class City < ActiveRecord::Base  
  end

  def self.up   
    city = City.new(:title => "Москва", :status => 1) 
    city.save!
    city = City.new(:title => "Питер", :status => 1) 
    city.save!
    city = City.new(:title => "Васюки", :status => 0) 
    city.save!
  end
  def self.down
    City.delete(City.find(:all))
  end
  
end
