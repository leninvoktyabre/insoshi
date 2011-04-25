class CreateGiftTypes < ActiveRecord::Migration
  def self.up
    create_table :gift_types do |t|
      t.string :title, :null => false
      t.integer :costs, :null => false, :default => 0
      t.string :image_path, :null => false
      t.integer :status, :default => 0,
                         :null => false,
                         :limit => 4

      t.timestamps
    end
  end

  def self.down
    drop_table :gift_types
  end
end
