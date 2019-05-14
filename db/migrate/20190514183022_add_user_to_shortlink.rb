class AddUserToShortlink < ActiveRecord::Migration[5.2]
  def change
    add_reference :shortlinks, :user, foreign_key: true
  end
end
