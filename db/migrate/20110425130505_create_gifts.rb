class CreateGifts < ActiveRecord::Migration
  def self.up
    create_table :gifts do |t|
      t.integer :person_id, :null => false
      t.integer :recipient_id, :null => false
      t.integer :gift_id, :null => false
      t.integer :status, :default => 0,
                         :null => false,
                         :limit => 4
      t.timestamps
    end
  end

  def self.down
    drop_table :gifts
  end
end
