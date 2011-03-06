class AddColumnsToAdverts < ActiveRecord::Migration
  class Advert < ActiveRecord::Base 
  end
  
  def self.up
    add_column :adverts, :city_id, :integer, :default => 0, :null => false, :limit => 4
    Advert.reset_column_information
  end

  def self.down
    remove_column :adverts, :city_id
  end
end
