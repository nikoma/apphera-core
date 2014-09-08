class AddPayloadToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :payload, :string
  end
end
