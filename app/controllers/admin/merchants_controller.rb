class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @merchant_name = @merchant.name
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant)
      flash[:notice] = "#{@merchant.name} has been successfully updated."
    else
      flash[:notice] = "Please enter a merchant name to continue."
      render :edit
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
