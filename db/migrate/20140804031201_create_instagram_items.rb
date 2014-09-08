class CreateInstagramItems < ActiveRecord::Migration
  def change
    create_table :instagram_items do |t|
      t.integer :keyword_id
      t.json :body

      t.timestamps
    end
    add_index :instagram_items, :keyword_id
  end
end
