class ChangeSpeciesTypeColumn < ActiveRecord::Migration
  def self.up
    remove_column :adverts, :species
    add_column :adverts, :species_id, :integer, :default => 0, :null => false, :limit => 4
  end

  def self.down
    remove_column :adverts, :species_id
    add_column :adverts, :species, :string
  end
end
