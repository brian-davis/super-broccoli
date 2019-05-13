class AddStatusToShortlink < ActiveRecord::Migration[5.2]
  def change
    add_column(:shortlinks, :status, :integer, { null: false, default: 0 })
  end
end
