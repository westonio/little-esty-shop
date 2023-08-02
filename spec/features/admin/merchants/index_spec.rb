require 'rails_helper'

RSpec.describe "Admin Merchants Index Page" do
  before :each do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde")
    @merchant_2 = Merchant.create!(name: "Klein, Rempel and Jones")
    @merchant_3 = Merchant.create!(name: "Willms and Sons")
    @merchant_4 = Merchant.create!(name: "Cummings-Thiel")
    @merchant_5 = Merchant.create!(name: "Williamson Group")
    @merchant_6 = Merchant.create!(name: "Bernhard-Johns")
    @merchant_7 = Merchant.create!(name: "Anna")
    @merchant_8 = Merchant.create!(name: "Luca")

    @joey = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
    @cecelia = Customer.create!(first_name: 'Cecelia', last_name: 'Osinski')
    @mariah = Customer.create!(first_name: 'Mariah', last_name: 'Toy')
    @leanne = Customer.create!(first_name: 'Leanne', last_name: 'Kuhn')
    @sylvester = Customer.create!(first_name: 'Sylvester', last_name: 'Braund')
    @heber = Customer.create!(first_name: 'Heber', last_name: 'Nader')
    @dejon = Customer.create!(first_name: 'Dejob', last_name: 'Hoppe')
    @logan = Customer.create!(first_name: 'Logan', last_name: 'Jenkins')

    @invoice_1 = @joey.invoices.create!()
    @invoice_2 = @joey.invoices.create!(status: 2)
    @invoice_3 = @cecelia.invoices.create!()
    @invoice_4 = @mariah.invoices.create!()
    @invoice_5 = @leanne.invoices.create!()
    @invoice_6 = @sylvester.invoices.create!()
    @invoice_7 = @heber.invoices.create!()
    @invoice_8 = @dejon.invoices.create!()
    @invoice_9 = @logan.invoices.create!()

    @item_1 = @merchant_1.items.create!(name: "Qui Esse", description: "Nihil autem sit odio inventore deleniti. Est laudantium ratione distincti", unit_price: 75107)
    @item_2 = @merchant_1.items.create!(name: "Autem Minima", description: "Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non.", unit_price: 67076)
    @item_3 = @merchant_2.items.create!(name: "Ea Voluptatum", description: "Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.", unit_price: 32301)
    @item_4 = @merchant_3.items.create!(name: "Nemo Facere", description: "Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias", unit_price: 15925)
    @item_5 = @merchant_4.items.create!(name: "Expedita Aliquam", description: "Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.", unit_price: 31163)
    @item_6 = @merchant_5.items.create!(name: "Provident At", description: "Reiciendis sed aperiam culpa animi laudantium. Eligendi veritatis sint dolorem asperiores. Earum alias illum eos non rerum.", unit_price: 22582)
    @item_7 = @merchant_6.items.create!(name: "Expedita Fuga", description: "Voluptatibus omnis quo recusandae distinctio voluptatem quibusdam et. Voluptas odio accusamus delectus sunt quia. Non atque rerum vitae officia odit.", unit_price: 42629)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 70000, status: 0)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 6, unit_price: 69000, status: 1)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 5, unit_price: 32000, status: 2)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 5, unit_price: 16000, status: 0)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 5, unit_price: 19000, status: 1)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 7, unit_price: 30000, status: 2)
    @invoice_item_7 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_7.id, quantity: 3, unit_price: 20000, status: 0)
    @invoice_item_8 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_8.id, quantity: 7, unit_price: 45000, status: 1)
    @invoice_item_9 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_9.id, quantity: 4, unit_price: 56000, status: 1)

    @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: "04/27", result: "success")
    @transaction_2 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: "04/27", result: "success")
    @transaction_3 = @invoice_1.transactions.create!(credit_card_number: 4654405418249632, credit_card_expiration_date: "04/27", result: "failed")
    @transaction_4 = @invoice_2.transactions.create!(credit_card_number: 4515551623735607, credit_card_expiration_date: "04/27", result: "success")
    @transaction_5 = @invoice_2.transactions.create!(credit_card_number: 4515551623735607, credit_card_expiration_date: "04/27", result: "failed")
    @transaction_6 = @invoice_3.transactions.create!(credit_card_number: 4536896898764278, credit_card_expiration_date: "04/27", result: "success")
    @transaction_7 = @invoice_3.transactions.create!(credit_card_number: 4536896898764278, credit_card_expiration_date: "04/27", result: "success")
    @transaction_8 = @invoice_4.transactions.create!(credit_card_number: 4252153331154380, credit_card_expiration_date: "04/27", result: "failed")
    @transaction_9 = @invoice_5.transactions.create!(credit_card_number: 4536896898764278, credit_card_expiration_date: "04/27", result: "success")
    @transaction_10 = @invoice_5.transactions.create!(credit_card_number: 4332881798016631, credit_card_expiration_date: "04/27", result: "success")
    @transaction_11 = @invoice_6.transactions.create!(credit_card_number: 4920121630073678, credit_card_expiration_date: "04/27", result: "success")
    @transaction_12 = @invoice_7.transactions.create!(credit_card_number: 4084466070588807, credit_card_expiration_date: "04/27", result: "success")
    @transaction_13 = @invoice_7.transactions.create!(credit_card_number: 4084466070588807, credit_card_expiration_date: "04/27", result: "success")
    @transaction_14 = @invoice_8.transactions.create!(credit_card_number: 4993984512460266, credit_card_expiration_date: "04/27", result: "success")
    @transaction_15 = @invoice_8.transactions.create!(credit_card_number: 4993984512460266, credit_card_expiration_date: "04/27", result: "failed")
    @transaction_16 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")
    @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4504301557459341, credit_card_expiration_date: "04/27", result: "success")

    visit admin_merchants_path
  end

  it "displays the name of each merchant in the system" do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_4.name)
    expect(page).to have_content(@merchant_5.name)
    expect(page).to have_content(@merchant_6.name)
    expect(page).to_not have_content("Johnson-Dickinson")
  end

  it "links to the merchant show page when you click the merchant's name" do
    within("#disabled-merchants") do
      click_link(@merchant_1.name)
    end
    expect(current_path).to eq(admin_merchant_path(@merchant_1))

    visit admin_merchants_path
    within("#disabled-merchants") do
      click_link(@merchant_2.name)
    end
    expect(current_path).to eq(admin_merchant_path(@merchant_2))
  end

  describe "disable/enable merchants button" do
    it "disables or enables the merchant when clicked" do
      expect(@merchant_1.status).to eq("disabled")
      click_button "Enable #{@merchant_1.name}"

      @merchant_1.reload
      expect(@merchant_1.status).to eq("enabled")


      visit admin_merchants_path
      expect(@merchant_2.status).to eq("disabled")
      click_button "Enable #{@merchant_2.name}"

      @merchant_2.reload
      expect(@merchant_2.status).to eq("enabled")
    end

    it "displays the updated merchant status once clicked" do
      click_button "Enable #{@merchant_1.name}"
      @merchant_1.reload
      
      expect(page).to have_button("Disable #{@merchant_1.name}")
      
      click_button "Disable #{@merchant_1.name}"
      @merchant_1.reload
      
      expect(page).to have_button("Enable #{@merchant_1.name}")
    end
  end

  it "displays the enabled and disabled merchants in two separate sections" do
    click_button "Enable #{@merchant_1.name}"
    click_button "Enable #{@merchant_2.name}"
    click_button "Enable #{@merchant_4.name}"
    click_button "Enable #{@merchant_6.name}"
    @merchant_1.reload
    @merchant_2.reload
    @merchant_4.reload
    @merchant_6.reload

    expect("Enabled Merchants").to appear_before("Disabled Merchants")

    within("#enabled-merchants") do
      expect(page).to have_content(@merchant_1.name)
      expect(page).to have_content(@merchant_2.name)
      expect(page).to have_content(@merchant_4.name)
      expect(page).to have_content(@merchant_6.name)
      expect(page).to_not have_content(@merchant_3.name)
    end

    within("#disabled-merchants") do
    expect(page).to have_content(@merchant_3.name)
    expect(page).to have_content(@merchant_5.name)
    expect(page).to_not have_content(@merchant_1.name)
    end
  end

  it "has a link to create a new merchant" do
    expect(page).to have_link("Create New Merchant")

    click_link("Create New Merchant")
    expect(current_path).to eq(new_admin_merchant_path)
  end

  it "displays the top 5 merchants by total revenue generated" do
    within("#top-merchants") do
    expect(page).to have_content(@merchant_1.name)
    expect(page).to have_content(@merchant_2.name)
    expect(page).to have_content(@merchant_4.name)
    expect(page).to have_content(@merchant_5.name)
    expect(page).to have_content(@merchant_6.name)
    end
  end

  it "links each top merchant name to its admin merchant show page" do
    within("#top-merchants") do
      click_link @merchant_1.name
      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end
  end

  xit "displays each top merchant's best sales day" do

  end
end