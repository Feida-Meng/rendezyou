class AddCountryIdToTour < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :country_id, :integer 
  end
end
