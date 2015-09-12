class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :message
      t.datetime :start
      t.datetime :end
      t.string :color
      t.integer :orner
      t.boolean :allday
      t.string :category
      t.string :place
      t.string :address
      t.integer :cost
      t.string :password

      t.timestamps
    end
  end
end
