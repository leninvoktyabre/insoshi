class AddColumnsToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :pet_id, :integer
  end

  def self.down
    remove_column :photos, :pet_id
  end
end
