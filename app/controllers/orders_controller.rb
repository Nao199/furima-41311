class OrdersController < ApplicationController
  before_action :set_item
  # ユーザーがログインしているかを確認する
  before_action :authenticate_user!, only: [:index, :create]
  # 商品が売却済みかどうかを確認する
  before_action :check_item_availability
  # 現在のユーザーが商品の出品者でないかを確認する
  before_action :check_item_owner

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @formobject = Formobject.new
  end

  def create
    @formobject = Formobject.new(formobject_params)
    if @formobject.valid?
      pay_item
      @formobject.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  # 商品が売却済みかどうかを確認する
  def check_item_availability
    redirect_to root_path if @item.sold_out?
  end

  # 現在のユーザーが商品の出品者でないかを確認する
  def check_item_owner
    redirect_to root_path if current_user == @item.user
  end

  def formobject_params
    params.require(:formobject).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number)
          .merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,        # 商品の金額
      card: @formobject.token,    # カードトークン
      currency: 'jpy'             # 通貨の種類（日本円）
    )
  end
end
