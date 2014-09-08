class CreateFacebookItems < ActiveRecord::Migration
  def change
    create_table :facebook_items do |t|
      t.integer :keyword_id
      t.json :body

      t.timestamps
    end
  end
end
