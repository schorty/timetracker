class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.date :beginning_of_day
      t.float :hours_worked
      t.integer :business
      t.integer :user_id

      t.timestamps
    end
  end
end
