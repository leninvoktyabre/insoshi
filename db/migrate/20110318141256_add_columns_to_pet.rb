class AddColumnsToPet < ActiveRecord::Migration
  def self.up
    add_column :pets, :status, :integer, :limit => 4, :default => 0, :null => false
    add_column :pets, :image_path, :string
    add_column :pets, :new_species, :string
    add_column :pets, :new_breed, :string
  end

  def self.down
    remove_column :pets, :image_path
    remove_column :pets, :status
    remove_column :pets, :new_species
    remove_column :pets, :new_breed
  end
end
