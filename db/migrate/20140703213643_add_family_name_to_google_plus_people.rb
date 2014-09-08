class AddFamilyNameToGooglePlusPeople < ActiveRecord::Migration
  def change
    add_column :google_plus_people, :given_name, :string
    add_column :google_plus_people, :family_name, :string
    add_index :google_plus_people, :family_name
  end
end
