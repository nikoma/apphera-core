class CreateFacebookPosts < ActiveRecord::Migration
  def change
    create_table :facebook_posts do |t|
      t.integer :account_id
      t.integer :organization_id
      t.date :post_date
      t.string :token
      t.string :body

      t.timestamps
    end
    add_index :facebook_posts, :account_id
    add_index :facebook_posts, :organization_id
    add_index :facebook_posts, :post_date
  end
end
