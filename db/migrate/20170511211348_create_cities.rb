class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.belongs_to :country, foreign_key: true
      t.timestamps
    end
  end
end
