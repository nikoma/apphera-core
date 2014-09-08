class EnablePostgis < ActiveRecord::Migration
  def change
    enable_extension :postgis
  end
end
