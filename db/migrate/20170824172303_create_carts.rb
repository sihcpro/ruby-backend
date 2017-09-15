class CreateCarts < ActiveRecord::Migration[5.1]
  def change
    create_table :carts do |t|
      t.belongs_to  :user
      t.belongs_to  :product
      t.integer     :quantity

      t.timestamps
    end
  end
end
