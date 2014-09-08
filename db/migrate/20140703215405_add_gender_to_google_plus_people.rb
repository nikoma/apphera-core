class AddGenderToGooglePlusPeople < ActiveRecord::Migration
  def change
    add_column :google_plus_people, :gender, :string
  end
end
