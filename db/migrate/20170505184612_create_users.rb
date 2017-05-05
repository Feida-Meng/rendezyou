class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :password
      t.string :password_digest
      t.string :picture
      t.string :username
      t.timestamps
    end
  end
end
