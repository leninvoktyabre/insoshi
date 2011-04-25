class AddStatusToAdvert < ActiveRecord::Migration
  def self.up
    add_column :adverts, :status, :integer, :limit => 4, :default => 0, :null => false
  end

  def self.down
    remove_column :adverts, :status
  end
end
