class AddToGooglePlusPeople < ActiveRecord::Migration
  # :gender url organizations:array verified:boolean places_lived:array circled_by_count:integer
  def change
    add_column :google_plus_people, :url, :string
    add_column :google_plus_people, :organizations, :string, array: true
    add_column :google_plus_people, :verified, :boolean
    add_column :google_plus_people, :places_lived, :string, array: true
    add_column :google_plus_people, :circled_by_count, :integer
  end
end
