class AddHashUrlToLinks < ActiveRecord::Migration[5.2]
  def change
    add_column :links, :hash_key, :string
    add_index :links, :hash_key, unique: true
  end
end
