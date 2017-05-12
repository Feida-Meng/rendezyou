class AddCapacityToTours < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
        dir.up { add_column :tours, :capacity, :integer }
        dir.down { remove_column :tours, :capacity, :integer }
      end
  end
end
