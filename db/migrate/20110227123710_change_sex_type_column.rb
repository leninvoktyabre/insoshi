class ChangeSexTypeColumn < ActiveRecord::Migration
  def self.up
    remove_column :adverts, :sex
    add_column :adverts, :sex_id, :integer, :default => 0, :null => false, :limit => 4
  end

  def self.down
    remove_column :adverts, :ex_id
    add_column :adverts, :sex, :string
  end
end
