class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.string :title, :null => false
      t.integer :status, :default => 0,
                         :null => false,
                         :limit => 4

      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
