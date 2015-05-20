class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.string :event
      t.string :description
      t.integer :points
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
