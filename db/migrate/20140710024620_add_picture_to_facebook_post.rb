class AddPictureToFacebookPost < ActiveRecord::Migration
  def change
    add_column :facebook_posts, :picture, :string
    add_column :facebook_posts, :link, :string
    add_column :facebook_posts, :name, :string
    add_column :facebook_posts, :description, :string
  end
end
