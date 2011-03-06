class AddColumnsToPeople < ActiveRecord::Migration
  class Person < ActiveRecord::Base 
  end
  
  def self.up
    add_column :people, :city_id, :integer, :default => 0, :null => false, :limit => 4
    Person.reset_column_information
  end

  def self.down
    remove_column :people, :city_id
  end
end
