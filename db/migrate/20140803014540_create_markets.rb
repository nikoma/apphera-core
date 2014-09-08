class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.string :name
      t.string :language

      t.timestamps
    end
    add_index :markets, :name
  end
end
