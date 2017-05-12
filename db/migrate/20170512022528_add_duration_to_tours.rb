class AddDurationToTours < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :duration_in_ms, :integer
  end
end
