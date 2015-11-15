class RemoveColumnsFromEvent < ActiveRecord::Migration
  def change
  	remove_columns :events, :latitude, :longitude
  end
end
