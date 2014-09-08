class AddCategoryToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :category, :string
    add_index :targets, :category
  end
end
