class Order < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one    :shipping_adderss
end
