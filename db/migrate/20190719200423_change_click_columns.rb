class ChangeClickColumns < ActiveRecord::Migration[5.2]
  def up
    change_column :clicks, :device, :integer
    change_column :clicks, :browser, :integer
  end

  def down
    change_column :clicks, :device, :string
    change_column :clicks, :browser, :string
  end
end
