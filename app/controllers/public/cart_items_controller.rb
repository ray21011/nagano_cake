class Public::CartItemsController < ApplicationController
  before_action :baria_user

  def index
      @cart_items = current_customer.cart_items.all
  end

  def create
    @cart_item_check = CartItem.find_by(customer_id: current_customer.id, item_id: params[:cart_item][:item_id])
    if @cart_item_check
      @cart_item_check.amount += params[:cart_item][:amount].to_i
      @cart_item_check.save
      flash[:success] = "カートに存在済のアイテムです"
      redirect_to cart_items_path
    else
      @cart_item = CartItem.new(cart_item_params)
      @cart_item.customer_id = current_customer.id
      if @cart_item.save
        flash[:success] = "カートに追加しました"
        redirect_to cart_items_path
      else
        flash[:danger] = "予期せぬエラーが発生しました"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def destroy
      @cart_item = CartItem.find(params[:id])
      @cart_item.destroy
      flash[:alert] = "商品をカートから削除しました。"
      redirect_to cart_items_path
  end

  def destroy_all
    CartItem.where(customer_id: current_customer.id).destroy_all
    flash[:success] = "カートの中身を空にしました"
    redirect_back(fallback_location: root_path)
  end

  def update
      @cart_item = CartItem.find(params[:id])
      @cart_item.update(cart_item_params)
      flash[:notice] = "商品の数量を変更しました。"
      redirect_to cart_items_path
  end

  private
  def cart_item_params
  	  params.require(:cart_item).permit(:amount, :item_id)
  end

  def baria_user
    unless customer_signed_in?
      flash[:alert]= "ログインしてください。"
      redirect_to new_customer_session_path
    end
  end
end
