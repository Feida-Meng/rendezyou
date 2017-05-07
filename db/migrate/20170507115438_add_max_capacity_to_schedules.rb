class AddMaxCapacityToSchedules < ActiveRecord::Migration[5.1]
  def change
    add_column :schedules, :max_capacity, :integer
  end
end
