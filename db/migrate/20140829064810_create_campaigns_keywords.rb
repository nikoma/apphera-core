class CreateCampaignsKeywords < ActiveRecord::Migration
  def change
    create_table :campaigns_keywords, :id => false do |t|
      t.integer :campaign_id
      t.integer :keyword_id
    end
    add_index :campaigns_keywords, :campaign_id
    add_index :campaigns_keywords, :keyword_id
  end
end
