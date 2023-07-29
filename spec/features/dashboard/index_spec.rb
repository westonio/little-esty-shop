require "rails_helper"

RSpec.describe "Merchant Dashboard" do
  before(:each) do
    @m1 = Merchant.create!(name: "Schroeder-Jerde")
    @m2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @m3 = Merchant.create!(name: "Willms and Sons")
    @m4 = Merchant.create!(name: "Cummings-Thiel")
    @m5 = Merchant.create!(name: "Williamson Group")

    @item_1 = @m3.items.create!(name: "figurine", description: "this is a figurine", unit_price: 1500, status: 1)
    @item_2 = @m3.items.create!(name: "robot", description: "this is a robot", unit_price: 9000, status: 1)
    @item_3 = @m3.items.create!(name: "novelty pencil", description: "this is a novelty pencil", unit_price: 2700, status: 1)
    @item_4 = @m3.items.create!(name: "toy sword", description: "this is a toy sword", unit_price: 7700, status: 1)
    @item_5 = @m3.items.create!(name: "bouncy ball", description: "this is a bouncy ball", unit_price: 50, status: 0)

    @customer_1 = Customer.create!(first_name: "Edgar", last_name: "Poe")
    @customer_2 = Customer.create!(first_name: "Rosa", last_name: "Clarkson")
    @customer_3 = Customer.create!(first_name: "Sweeney", last_name: "Todd")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 0)
    @invoice_2 = Invoice.create!(customer_id: @customer_2.id, status: 0)
    @invoice_3 = Invoice.create!(customer_id: @customer_3.id, status: 0)

    @invoiceitem_1 = @item_1.invoice_items.create!(status: 0, invoice_id: @invoice_1.id, unit_price: 1500, quantity: 1)
    @invoiceitem_1 = @item_2.invoice_items.create!(status: 1, invoice_id: @invoice_2.id, unit_price: 9000, quantity: 1)
    @invoiceitem_1 = @item_3.invoice_items.create!(status: 1, invoice_id: @invoice_1.id, unit_price: 2700, quantity: 1)
    @invoiceitem_1 = @item_4.invoice_items.create!(status: 2, invoice_id: @invoice_3.id, unit_price: 7700, quantity: 1)
  end
  #user story 1
  it "displays the name of each merchant" do
    visit "/merchants/#{@m1.id}/dashboard"

    expect(page).to have_content(@m1.name)
    expect(page).to_not have_content(@m2.name)
  end
  #user story 2
  it "displays a link to merchant items index and merchant invoices index pages" do
    visit "/merchants/#{@m1.id}/dashboard"

    expect(page).to have_link("My Items")
    expect(page).to have_link("My Invoices")
    expect(page).to_not have_link("Admin")
  end
  #user story 3
  it "displays the names of the top 5 customers" do
    visit "/merchants/#{@m3.id}/dashboard"

    expect(page).to have_content("Favorite Customers")
  end
end