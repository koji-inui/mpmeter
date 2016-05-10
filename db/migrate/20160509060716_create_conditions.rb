class CreateConditions < ActiveRecord::Migration
  def change
    create_table :conditions do |t|
      t.integer :user_id
      t.date :cday
      t.integer :mp
      t.integer :hp
      t.integer :temperature
      t.string :whether
      t.float :sleep_time
      t.integer :eja_times
      t.text :noting

      t.timestamps null: false
    end
  end
end
