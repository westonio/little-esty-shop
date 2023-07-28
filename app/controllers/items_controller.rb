class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    # require 'pry'; binding.pry
    if @item.update(item_params)
      if item_params[:status].present?
        redirect_to merchant_items_path(@merchant)
      else
        flash[:notice] = "#{@item.name} has been updated!"
        redirect_to merchant_item_path(@merchant, @item)
      end
    else
      render "edit"
    end
  end

  def new
    
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :id, :merchant_id, :status)
  end


end