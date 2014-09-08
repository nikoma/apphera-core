class AddApiPartnerIdToFacebookPost < ActiveRecord::Migration
  def change
    add_column :facebook_posts, :api_partner_id, :integer
    add_index :facebook_posts, :api_partner_id
  end
end
