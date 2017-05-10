class AddDefaultValueToSchedules < ActiveRecord::Migration[5.1]
  def change
    change_column :schedules, :current_capacity, :integer, :default => 0
  end
end
