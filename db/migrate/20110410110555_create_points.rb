class CreatePoints < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.integer :person_id
      t.string :object
      t.integer :object_id
      t.integer :value, :default => 0, :null => false
      t.integer :status, :default => 1, :null => false, :limit => 4

      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
