class ChangeTextToStringOnCampaigns < ActiveRecord::Migration
  def change
    change_column :campaigns, :description, :string
  end
end
