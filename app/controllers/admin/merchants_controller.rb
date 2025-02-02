class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
    @merchant_name = @merchant.name
    get_random_photo
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      if merchant_params[:status].present?
        redirect_to admin_merchants_path
      else
        redirect_to admin_merchant_path(@merchant)
        flash[:notice] = "#{@merchant.name} has been successfully updated."
      end
    else
      flash[:notice] = 'Please enter a merchant name to continue.'
      render :edit
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new
  end


  def create
    @merchant = Merchant.new(new_merchant_params)
    if @merchant.save
      redirect_to admin_merchants_path
    else
      flash[:notice] = "Please enter a merchant name to continue."
      render "new"
    end
  end

  private

  def new_merchant_params
    params.permit(:name, :status)
  end

  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end
