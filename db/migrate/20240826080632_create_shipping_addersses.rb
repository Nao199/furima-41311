class CreateShippingAddersses < ActiveRecord::Migration[7.0]
  def change
    create_table :shipping_addersses do |t|
      t.string     :postal_code,   null: false
      t.integer    :prefecture_id, null: false
      t.string     :city,          null: false
      t.string     :address,       null: false
      t.string     :building,      null: false
      t.string     :phone_number
      t.references :order,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
