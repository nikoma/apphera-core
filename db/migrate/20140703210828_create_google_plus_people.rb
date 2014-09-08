class CreateGooglePlusPeople < ActiveRecord::Migration
  def change
    create_table :google_plus_people do |t|
      t.string :kind
      t.string :gid
      t.string :image_url
      t.string :object_type
      t.string :display_name

      t.timestamps
    end
    add_index :google_plus_people, :gid
    add_index :google_plus_people, :display_name
  end
end
