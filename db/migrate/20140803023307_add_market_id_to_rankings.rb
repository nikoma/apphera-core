class AddMarketIdToRankings < ActiveRecord::Migration
  def change
    add_column :rankings, :market_id, :integer
    add_index :rankings, :market_id
  end
end
