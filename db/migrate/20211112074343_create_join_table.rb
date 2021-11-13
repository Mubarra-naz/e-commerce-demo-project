class CreateJoinTable < ActiveRecord::Migration[6.1]
  def change
<<<<<<< HEAD
    create_join_table :products, :coupons do |t|
      t.index [:coupon_id, :product_id]
      t.index [:product_id, :coupon_id]
=======
    create_join_table :categories, :coupons do |t|
      # t.index [:coupon_id, :category_id]
      # t.index [:category_id, :coupon_id]
>>>>>>> 09ff54e (coupon-category association added, slect2 gem used)
    end
  end
end
