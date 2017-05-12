class RemoveCountryFromTours < ActiveRecord::Migration[5.1]
  def change
    remove_column :tours, :country, :string
  end
end
