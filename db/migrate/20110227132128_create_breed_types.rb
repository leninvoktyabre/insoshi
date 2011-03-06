class CreateBreedTypes < ActiveRecord::Migration
  def self.up
    create_table :breed_types do |t|
      t.string :title, :null => false
      t.integer :status, :default => 0,
                         :null => false,
                         :limit => 4
      t.integer :species_id, :default => 0,
                             :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :breed_types
  end
end
