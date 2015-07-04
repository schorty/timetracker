class CreateConfigurations < ActiveRecord::Migration
  def change
    create_table :configurations do |t|
      t.integer :daily_worktime
      t.float :overtime_bonus
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
