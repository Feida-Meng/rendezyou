class AddAvatarColumnsToTourPoints < ActiveRecord::Migration[5.1]
  def up
    add_attachment :tourpoints, :avatar
  end

  def down
    remove_attachment :tourpoints, :avatar
  end
end
