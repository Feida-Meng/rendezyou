class RenameTourTimeToTourStartTimeForSchedule < ActiveRecord::Migration[5.1]
  def change
    rename_column :schedules, :tourtime, :tour_start_time
  end
end
