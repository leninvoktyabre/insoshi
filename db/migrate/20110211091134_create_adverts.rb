class CreateAdverts < ActiveRecord::Migration
  def self.up
    create_table :adverts do |t|
      t.string :deal
      t.string :species
      t.string :sex
      t.decimal :price, :precision => 8, :scale => 2
      t.string :title
      t.string :description
      t.references :person

      t.timestamps
    end
  end

  def self.down
    drop_table :adverts
  end
end
