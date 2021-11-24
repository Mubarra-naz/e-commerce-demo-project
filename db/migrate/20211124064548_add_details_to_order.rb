class AddDetailsToOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :discount, :decimal
    add_column :orders, :payment_method, :string
  end
end
