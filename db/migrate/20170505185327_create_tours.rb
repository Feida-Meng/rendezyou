class CreateTours < ActiveRecord::Migration[5.1]
  def change
    create_table :tours do |t|
      t.string :name
      t.string :description
      t.string :city
      t.string :country
      t.string :address
      t.integer :user_id
      t.string :category
      t.integer :capacity

      t.timestamps
    end
  end
end
