class ChangeDateToDatetimeInFacebookPosts < ActiveRecord::Migration
  def change
    change_column :facebook_posts, :post_date, :datetime
  end
end
