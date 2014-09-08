class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :name
      t.string :street
      t.string :postalcode
      t.string :phone
      t.string :city
      t.string :state
      t.string :url
      t.integer :reviews

      t.timestamps
    end
  end
end
