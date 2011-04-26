class AddColumnsToGift < ActiveRecord::Migration
  def self.up
    remove_column :gifts, :gift_id
    add_column :gifts, :gift_type_id, :integer, :null => false
  end

  def self.down
    remove_column :gifts, :gift_type_id
    add_column :gifts, :gift_id, :integer, :null => false
  end
end
