class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_root

  def index
    @log_order = LogOrder.new
  end

  def create
    @log_order = LogOrder.new(log_order_params)
    if @log_order.valid?
      pay_item
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
    params.require(:log_order).permit(:postal_code, :prefecture_id, :city, :address_line1, :address_line2, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: log_order_params[:token],
        currency: 'jpy'
      )
  end

  def move_to_root
    if @item.user_id == current_user.id || @item.log.present?
      redirect_to root_path
    end
  end
end
