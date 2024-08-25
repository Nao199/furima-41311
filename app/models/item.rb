class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  # has_one    :order

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :shipping_day

  # 空の投稿を保存できないようにする
  validates :image, :name, :description, :price, presence: true

  validates :price,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: lambda do |_object, data|
                if data[:value].to_i.to_s != data[:value].to_s
                  'Please enter a half-width numeric value'
                else
                  'must be less than or equal to 9999999'
                end
              end
            }

  # sold_out? メソッドの実装
  # def sold_out?
  # order.present?
  # end

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: "can't be blank" }
end
