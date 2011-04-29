class AddNewColumnsToAdvert < ActiveRecord::Migration
  def self.up
    add_column :adverts, :new_species, :string
    add_column :adverts, :new_breed, :string
  end

  def self.down
    remove_column :adverts, :new_breed
    remove_column :adverts, :new_species
  end
end
