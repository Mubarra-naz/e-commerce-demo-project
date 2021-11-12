class CreateCoupons < ActiveRecord::Migration[6.1]
  def change
    create_table :coupons do |t|
      t.string :name
      t.decimal :discount
      t.string :discount_type

      t.timestamps
    end
  end
end
