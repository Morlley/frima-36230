class OrdersController < ApplicationController
before_action :set_item, only: [:index, :create]

  def index
    @log_order = LogOrder.new
  end

  def create
    @log_order = LogOrder.new(log_order_params)
    if @log_order.valid?
      @log_order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def log_order_params
    params.require(:log_order).permit(:postal_code, :prefecture_id, :city, :address_line1, :address_line2, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
