class AddColumnsToAdvert < ActiveRecord::Migration
  def self.up
    add_column :adverts, :breed_id, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :adverts, :breed_id
  end
end
