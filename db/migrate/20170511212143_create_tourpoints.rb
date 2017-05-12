class CreateTourpoints < ActiveRecord::Migration[5.1]
  def change
    create_table :tourpoints do |t|
      t.string :tour_point_name
      t.jsonb :tour_point_laglng
      t.string :tour_point_img
      t.string :tour_point_description
      t.belongs_to :tour, foreign_key: true

      t.timestamps
    end
  end
end
