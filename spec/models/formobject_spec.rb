require 'rails_helper'

RSpec.describe Formobject, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @formobject = FactoryBot.build(:formobject, user_id: @user.id, item_id: @item.id)
  end

  describe '購入機能' do
    context '購入できるとき' do
      it '全ての属性が有効な場合' do
        expect(@formobject).to be_valid
      end

      it '建物名が空でも購入できる' do
        @formobject.building = ''
        expect(@formobject).to be_valid
      end
    end

    context '購入できないとき' do
      it '郵便番号が空の場合、無効であること' do
        @formobject.postal_code = ''
        @formobject.valid?
        expect(@formobject.errors[:postal_code]).to include("can't be blank")
      end

      it '郵便番号のフォーマットが不正な場合、無効であること' do
        @formobject.postal_code = '1234567'
        @formobject.valid?
        expect(@formobject.errors[:postal_code]).to include("must be in the format '123-4567'")
      end

      it '都道府県が選択されていない場合（prefecture_id が 1 の場合）、無効であること' do
        @formobject.prefecture_id = 1
        @formobject.valid?
        expect(@formobject.errors[:prefecture_id]).to include('must be selected')
      end

      it '市区町村が空の場合、無効であること' do
        @formobject.city = ''
        @formobject.valid?
        expect(@formobject.errors[:city]).to include("can't be blank")
      end

      it '番地が空の場合、無効であること' do
        @formobject.address = ''
        @formobject.valid?
        expect(@formobject.errors[:address]).to include("can't be blank")
      end

      it '電話番号が空の場合、無効であること' do
        @formobject.phone_number = ''
        @formobject.valid?
        expect(@formobject.errors[:phone_number]).to include("can't be blank")
      end

      it '電話番号が9桁以下の場合、無効であること' do
        @formobject.phone_number = '123456789'
        @formobject.valid?
        expect(@formobject.errors[:phone_number]).to include('must be 10 or 11 digits')
      end

      it '電話番号が12桁以上の場合、無効であること' do
        @formobject.phone_number = '123456789012'
        @formobject.valid?
        expect(@formobject.errors[:phone_number]).to include('must be 10 or 11 digits')
      end

      it '電話番号に半角数字以外が含まれる場合、無効であること' do
        @formobject.phone_number = '090-1234-5678'
        @formobject.valid?
        expect(@formobject.errors[:phone_number]).to include('must be 10 or 11 digits')
      end
      
      it '電話番号に全角数字が含まれる場合、無効であること' do
        @formobject.phone_number = '０９０１２３４５６７８'
        @formobject.valid?
        expect(@formobject.errors[:phone_number]).to include('must be 10 or 11 digits')
      end
      
      it '電話番号にアルファベットが含まれる場合、無効であること' do
        @formobject.phone_number = '090abcd5678'
        @formobject.valid?
        expect(@formobject.errors[:phone_number]).to include('must be 10 or 11 digits')
      end

      it 'トークンが空の場合、無効であること' do
        @formobject.token = ''
        @formobject.valid?
        expect(@formobject.errors[:token]).to include("can't be blank")
      end

      it 'user_idが空の場合、無効であること' do
        @formobject.user_id = nil
        @formobject.valid?
        expect(@formobject.errors[:user_id]).to include("can't be blank")
      end

      it 'item_idが空の場合、無効であること' do
        @formobject.item_id = nil
        @formobject.valid?
        expect(@formobject.errors[:item_id]).to include("can't be blank")
      end
    end
  end
end
