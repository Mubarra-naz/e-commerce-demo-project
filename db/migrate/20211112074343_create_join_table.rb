class CreateJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :products, :coupons do |t|
      t.index [:coupon_id, :product_id]
      t.index [:product_id, :coupon_id]
    end
  end
end
