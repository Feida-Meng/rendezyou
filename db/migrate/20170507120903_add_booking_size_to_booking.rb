class AddBookingSizeToBooking < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :booking_size, :integer
  end
end
