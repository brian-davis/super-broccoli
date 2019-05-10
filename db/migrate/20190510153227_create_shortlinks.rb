class CreateShortlinks < ActiveRecord::Migration[5.2]
  def change
    create_table :shortlinks do |t|
      t.text :source, null: false
      t.string :slug, null: false
      t.integer :click_count, default: 0

      t.timestamps
      t.index :slug, unique: true
    end
  end
end
