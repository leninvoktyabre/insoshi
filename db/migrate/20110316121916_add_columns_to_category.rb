class AddColumnsToCategory < ActiveRecord::Migration
  def self.up
    add_column :categories, :title_safe, :string
  end

  def self.down
    remove_column :categories, :title_safe
  end
end
