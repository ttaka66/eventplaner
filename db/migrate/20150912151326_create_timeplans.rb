class CreateTimeplans < ActiveRecord::Migration
  def change
    create_table :timeplans do |t|
      t.references :event, index: true
      t.datetime :start
      t.datetime :end
      t.string :place
      t.string :address

      t.timestamps
    end
  end
end
