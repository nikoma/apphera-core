class CreateGooglePlusUsers < ActiveRecord::Migration
  def change
    create_table :google_plus_users do |t|
      t.string :display_name
      t.string :gender
      t.string :kind
      t.string :url
      t.string :image_url
      t.hstore :places_lived
      t.hstore :organizations
      t.boolean :verified

      t.timestamps
    end
    add_index :google_plus_users, :display_name
    add_index :google_plus_users, :gender
  end
end
