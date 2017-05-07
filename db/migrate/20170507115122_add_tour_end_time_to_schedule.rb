class AddTourEndTimeToSchedule < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :tour_end_time, :datetime
  end
end
