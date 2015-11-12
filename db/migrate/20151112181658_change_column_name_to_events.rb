class ChangeColumnNameToEvents < ActiveRecord::Migration
  def change
  	rename_column :events, :orner, :owner_id
  end
end
