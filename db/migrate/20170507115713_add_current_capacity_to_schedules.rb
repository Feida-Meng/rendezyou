class AddCurrentCapacityToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :current_capacity, :integer
  end
end
