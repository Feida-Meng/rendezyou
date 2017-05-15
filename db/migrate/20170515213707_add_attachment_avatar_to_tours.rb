class AddAttachmentAvatarToTours < ActiveRecord::Migration[5.1]
  def self.up
    change_table :tours do |t|
      t.attachment :tourpic
    end
  end

  def self.down
    remove_attachment :tours, :tourpic
  end
end
