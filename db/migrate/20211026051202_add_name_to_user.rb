class AddNameToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string, null: false
    add_column :users, :lastname, :string,null: false

    add_index :users, [:firstname, :lastname], unique: true
  end
end
