class DropTableCities < ActiveRecord::Migration[5.1]
  def change
    drop_table :cities
  end
end
