class CreatePets < ActiveRecord::Migration
  def self.up
    create_table :pets do |t|
      t.string :species
      t.string :sex
      t.string :name
      t.string :age
      t.string :description
      t.references :person

      t.timestamps
    end
  end

  def self.down
    drop_table :pets
  end
end
