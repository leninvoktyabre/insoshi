class AddColumnsToLink < ActiveRecord::Migration
  def self.up
    add_column :links, :status, :integer, :default => 0,
                                           :null => false,
                                           :limit => 4
  end

  def self.down
    remove_column :links, :status
  end
end
