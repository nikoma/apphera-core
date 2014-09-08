class CreateNamedQueries < ActiveRecord::Migration
  def change
    create_table :named_queries do |t|
      t.string :name
      t.integer :api_partner_id
      t.integer :account_id
      t.string :description
      t.json :query
      t.json :placeholders

      t.timestamps
    end
    add_index :named_queries, :name
    add_index :named_queries, :api_partner_id
    add_index :named_queries, :account_id
  end
end
