class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(8)
    @items_all = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def search
    @items = Item.page(params[:page]).per(10)
    @word_for_search = Genri.find(params[:word_for_search])
    @search_item = Item.where(genre: params[:word_for_search])
  end
  
  # private
  # def item_params
  #   params.require(:items).permit(:name, :introduction, :price, :)
  # end
end
