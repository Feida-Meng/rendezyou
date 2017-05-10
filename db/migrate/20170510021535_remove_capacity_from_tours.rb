class RemoveCapacityFromTours < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
        dir.up { remove_column :tours, :capacity, :integer }
        dir.down { add_column :tours, :capacity, :integer }
      end
  end
end
