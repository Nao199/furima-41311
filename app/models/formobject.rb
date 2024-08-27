class Formobject
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "must be in the format '123-4567'" }
    validates :prefecture_id, numericality: { other_than: 1, message: 'must be selected' }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'must be 10 or 11 digits' }
    validates :token
  end

  
  def save
    ActiveRecord::Base.transaction do
      order = Order.create(user_id:, item_id:)
      ShippingAdderss.create(
        order_id: order.id,
        postal_code:,
        prefecture_id:,
        city:,
        address:,
        building:,
        phone_number:
      )
    end
  end
end
