class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  # ユーザーがログインしているかを確認する
  before_action :authenticate_user!, except: [:index, :show]
  # 現在のユーザーが商品の出品者であるかを確認する
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]
  # 商品が売却済みかどうかを確認する
  before_action :check_item_sold, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc) # 出品日時が新しい順にソート
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :condition_id, :shipping_fee_status_id,
                                 :prefecture_id, :shipping_day_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @item.user
  end

  # 商品が売却済みかどうかを確認する
  def check_item_sold
    return unless @item.sold_out?

    redirect_to root_path
  end
end
