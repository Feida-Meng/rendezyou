class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.datetime :tourtime
      t.integer :tour_id

      t.timestamps
    end
  end
end
