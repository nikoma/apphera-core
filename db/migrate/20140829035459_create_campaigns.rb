class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :account_id
      t.datetime :start_date
      t.datetime :end_date
      t.text :description

      t.timestamps
    end
    add_index :campaigns, :account_id
    add_index :campaigns, :start_date
    add_index :campaigns, :end_date
  end
end
