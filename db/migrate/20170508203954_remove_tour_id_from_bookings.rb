class RemoveTourIdFromBookings < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
        dir.up { remove_column :bookings, :tour_id, :integer }
        dir.down { add_column :bookings, :tour_id, :integer }
      end
  end
end
