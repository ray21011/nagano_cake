class Public::CustomersController < ApplicationController
  def show
    @user = current_customer
  end
  
  def unsubscribe
  end

  def edit
    @user = current_customer
  end

  def update
    @user = current_customer
    @user.update(curent_params)
    redirect_to customers_mypage_path(current_customer)
  end

  def withdrawal
    @user = current_customer
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private

  def curent_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end
end
