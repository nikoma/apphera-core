class AddMarketsToKeywords < ActiveRecord::Migration
  def change
    add_column :keywords, :markets, :json
  end
end
