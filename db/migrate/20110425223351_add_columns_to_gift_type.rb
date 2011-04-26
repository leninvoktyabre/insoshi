class AddColumnsToGiftType < ActiveRecord::Migration
  def self.up
    add_column :gift_types, :description, :text
  end

  def self.down
    remove_column :gift_types, :description
  end
end
