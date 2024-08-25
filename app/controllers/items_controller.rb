class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @items = Item.order(created_at: :desc) # 出品日時が新しい順にソート
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(:image,
                                 :name,
                                 :description,
                                 :category_id,
                                 :condition_id,
                                 :shipping_fee_status_id,
                                 :prefecture_id,
                                 :shipping_day_id,
                                 :price).merge(user_id: current_user.id)
  end
end
