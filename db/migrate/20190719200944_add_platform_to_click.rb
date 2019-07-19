class AddPlatformToClick < ActiveRecord::Migration[5.2]
  def change
    add_column :clicks, :platform, :integer
  end
end
