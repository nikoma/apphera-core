class CreateKeywordAggregates < ActiveRecord::Migration
  def change
    create_table :keyword_aggregates do |t|
      t.integer :keyword_id
      t.json :aggregates

      t.timestamps
    end
    add_index :keyword_aggregates, :keyword_id
  end
end
