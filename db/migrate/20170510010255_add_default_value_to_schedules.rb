class AddDefaultValueToSchedules < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
        dir.up { change_column :schedules, :current_capacity, :integer, :default => 0 }
        dir.down { change_column :schedules, :current_capacity, :integer }
      end

  end
end
