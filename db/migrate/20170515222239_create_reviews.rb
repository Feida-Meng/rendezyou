class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.text :comment
      t.integer :author_id
      t.belongs_to :tour, foreign_key: true

      t.timestamps
    end
  end
end
