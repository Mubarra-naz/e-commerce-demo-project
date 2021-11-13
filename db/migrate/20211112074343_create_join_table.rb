class CreateJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :categories, :coupons do |t|
      # t.index [:coupon_id, :category_id]
      # t.index [:category_id, :coupon_id]
    end
  end
end
