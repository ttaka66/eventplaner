class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :own_id
      t.integer :friend_id

      t.timestamps
    end
    add_index :relationships, :own_id
    add_index :relationships, :friend_id
    add_index :relationships, [:own_id, :friend_id], unique: true
  end
end
