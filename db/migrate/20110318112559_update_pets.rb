class UpdatePets < ActiveRecord::Migration
  def self.up
    remove_column :pets, :species
    remove_column :pets, :sex
    remove_column :pets, :age
    remove_column :pets, :description
    add_column :pets, :species_id, :integer, :default => 0, :null => false, :limit => 4
    add_column :pets, :sex_id, :integer, :default => 0, :null => false, :limit => 4
    add_column :pets, :breed_id, :integer, :default => 0, :null => false, :limit => 4
    add_column :pets, :date_of_birth, :datetime
    add_column :pets, :color, :string
    add_column :pets, :fav_food, :string
    add_column :pets, :description, :text
  end

  def self.down
    add_column :pets, :species, :string
    add_column :pets, :sex, :string
    add_column :pets, :age, :string
    remove_column :pets, :species_id
    remove_column :pets, :sex_id
    remove_column :pets, :breed_id
    remove_column :pets, :date_of_birth
    remove_column :pets, :color
    remove_column :pets, :fav_food
  end
end
