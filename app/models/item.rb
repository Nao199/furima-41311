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
  #validates :title, :text, presence: true

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, :condition_id, :shipping_fee_status_id, :prefecture_id, :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"}

end
