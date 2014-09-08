class CreateNewsItems < ActiveRecord::Migration
  def change
    create_table :news_items do |t|
      t.integer :keyword_id
      t.json :body
      t.integer :market_id

      t.timestamps
    end
    add_index :news_items, :keyword_id
    add_index :news_items, :market_id
  end
end
