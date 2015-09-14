class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :user, index: true
      t.references :timeplan, index: true
      t.boolean :attendance, default: false
      t.string :message

      t.timestamps
    end
  end
end
