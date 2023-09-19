class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @orders = Order.all
    @order_details = OrderDetail.where(order_id: @order)
    @total_price = 0
    @total_price_tax = 0
    @order_details.each do |order_detail|
    @total_price += order_detail.purchase_price * order_detail.amount
    end
    @order_details.each do |order_detail|
    @total_price_tax += order_detail.purchase_price * order_detail.amount
    end
    @production_status = @order.order_details.pluck(:purchase_price)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
    if @order.update(order_status_params)
      if @order.order_status.include?("入金確認")
         @order_details.update( production_status: 1)
      end
    flash[:success] = "制作ステータスを変更しました。"
    redirect_to admin_order_path(@order)
    else
      render "show"
    end
  end

  private

  def order_status_params
    params.require(:order).permit(:order_status)
  end
end
