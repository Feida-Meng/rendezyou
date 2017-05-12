class RemoveTourEndTimeFromSchedules < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up { remove_column :schedules, :tour_end_time}
      dir.down { add_column :schedules, :tour_end_time, :datetime}
    end
  end
end
