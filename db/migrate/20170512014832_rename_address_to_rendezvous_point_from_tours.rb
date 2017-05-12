class RenameAddressToRendezvousPointFromTours < ActiveRecord::Migration[5.1]
  def change
    rename_column :tours, :address, :rendezvous_point
  end
end
