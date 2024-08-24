class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :shipping_day

  #空の投稿を保存できないようにする
  validates :image, :name, :description, :price, presence: true

  #価格は、¥300‐¥9999999の間のみ保存可能
  validates :price, presence: true,
  numericality: {
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    message: "must be less than or equal to 9999999"
  }
  #価格は、半角数字のみ保存可能
  validates :price, presence: true,
  numericality: { only_integer: true, message: "は半角数値で入力してください" }
  
  #ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"}

end
