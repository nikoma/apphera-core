class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :organization_id
      t.string :title
      t.string :author
      t.datetime :published
      t.string :synopsis

      t.timestamps
    end
    add_index :posts, :organization_id
  end
end
