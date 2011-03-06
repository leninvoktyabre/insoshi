class ChangeDealTypeColumn < ActiveRecord::Migration
  def self.up
    remove_column :adverts, :deal
    add_column :adverts, :deal_id, :integer, :default => 0, :null => false, :limit => 4
  end

  def self.down
    remove_column :adverts, :deal_id
    add_column :adverts, :deal, :string
  end
end
