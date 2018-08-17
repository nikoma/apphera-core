class AddUrlToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :url, :string
  end
end
