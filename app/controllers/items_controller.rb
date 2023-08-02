class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    search_item_photos(@item.name)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      if item_params[:status].present?
        redirect_to merchant_items_path(@merchant)
      else
        flash[:notice] = "#{@item.name} has been updated!"
        redirect_to merchant_item_path(@merchant, @item)
      end
    else
      render 'edit'
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(new_items_params)
    if @item.save
      redirect_to merchant_items_path(@merchant)
    else
      render :new
    end
  end

  private

  def new_items_params
    params.permit(:name, :description, :unit_price, :status)
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end
