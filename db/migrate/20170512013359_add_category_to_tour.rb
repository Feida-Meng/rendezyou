class AddCategoryToTour < ActiveRecord::Migration[5.1]
  def change
    add_column :tours, :category, :integer
  end
end
