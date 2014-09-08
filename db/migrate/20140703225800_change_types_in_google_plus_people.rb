class ChangeTypesInGooglePlusPeople < ActiveRecord::Migration
  def change
    remove_column :google_plus_people, :organizations
    remove_column :google_plus_people, :places_lived
    add_column :google_plus_people, :organizations, :hstore
    add_column :google_plus_people, :places_lived, :hstore
  end
end
