class AddTourIdtoBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :tour_id, :integer
  end
end
