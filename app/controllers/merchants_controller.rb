class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    render 'index'
  end
end
