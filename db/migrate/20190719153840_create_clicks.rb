class CreateClicks < ActiveRecord::Migration[5.2]
  def change
    create_table :clicks do |t|
      t.references :shortlink, foreign_key: true
      t.string :ip_address
      t.string :user_agent
      t.string :referer
      t.string :device
      t.string :browser
      t.string :location

      t.timestamps
    end
  end
end
