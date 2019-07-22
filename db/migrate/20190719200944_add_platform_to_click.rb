# frozen_string_literal: true

# AddPlatformToClick adds a 3rd enum
class AddPlatformToClick < ActiveRecord::Migration[5.2]
  def change
    add_column :clicks, :platform, :integer
  end
end
