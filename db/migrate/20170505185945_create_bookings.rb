class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.integer :schedule_id
      t.boolean :confirm

      t.timestamps
    end
  end
end
