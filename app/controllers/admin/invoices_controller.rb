class Admin::InvoicesController < ApplicationController
<<<<<<< Updated upstream

=======
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
>>>>>>> Stashed changes
end