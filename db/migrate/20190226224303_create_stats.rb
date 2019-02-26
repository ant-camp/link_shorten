class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.integer :clicks, default: 0, null: false
      t.references :link, foreign_key: true

      t.timestamps
    end
  end
end
