class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :client_name, null: false
      t.string :auth_token

      t.timestamps
    end
    add_index :users, :auth_token, unique: true
  end
end
