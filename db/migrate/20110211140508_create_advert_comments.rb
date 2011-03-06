class CreateAdvertComments < ActiveRecord::Migration
  def self.up
    create_table :advert_comments do |t|
      t.integer :commenter_id
      t.text :body
      t.references :advert

      t.timestamps
    end
    # add_index :comments, :commenter_id
  end
  say "Created a table"

  def self.down
    drop_table :advert_comments
  end
end
