class RemoveColumnCategoryFromTableTour < ActiveRecord::Migration[5.1]
  def change
    remove_column :tours, :category, :string
  end
end
