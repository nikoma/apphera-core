class CreateFacebookPagePosts < ActiveRecord::Migration
  def change
    create_table :facebook_page_posts do |t|
      t.integer :api_partner_id
      t.string :page_id
      t.integer :account_id
      t.integer :organization_id
      t.datetime :post_date
      t.string :body
      t.string :picture
      t.string :link
      t.string :description
      t.boolean :post_as_user
      t.string :c_user_id

      t.timestamps
    end
    add_index :facebook_page_posts, :api_partner_id
    add_index :facebook_page_posts, :page_id
    add_index :facebook_page_posts, :account_id
    add_index :facebook_page_posts, :organization_id
  end
end
