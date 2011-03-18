class RemoveCategoryTypeFromCategory < ActiveRecord::Migration
  class Category < ActiveRecord::Base 
  end
  
  def self.up
    remove_column :categories, :category_type
  end

  def self.down
    add_column :categories, :category_type, :integer, :default => 0
  end
end
