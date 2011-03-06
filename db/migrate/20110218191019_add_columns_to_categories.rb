class AddColumnsToCategories < ActiveRecord::Migration
  class Category < ActiveRecord::Base 
  end
  
  def self.up
    add_column :categories, :parent_id, :integer, :default => 0
    add_column :categories, :category_type, :integer, :default => 0
    add_column :categories, :image_path, :string
    Category.reset_column_information 
  end

  def self.down
    remove_column :categories, :image_path
    remove_column :categories, :category_type
    remove_column :categories, :parent_id
  end
end
