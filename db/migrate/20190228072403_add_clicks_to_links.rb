class AddClicksToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :clicks, :integer, default: 0, null: false
  end
end
