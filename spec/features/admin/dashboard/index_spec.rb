require 'rails_helper'
require './app/helpers/application_helper'

RSpec.describe 'Admin Dashboard (index)', type: :feature do
  include ApplicationHelper
  describe 'When I visit the admin dashboard (/admin)' do
    before :each do
      @joey = Customer.create!(first_name: 'Joey', last_name: 'Ondricka')
      @cecelia = Customer.create!(first_name: 'Cecelia', last_name: 'Osinski')
      @mariah = Customer.create!(first_name: 'Mariah', last_name: 'Toy')
      @leanne = Customer.create!(first_name: 'Leanne', last_name: 'Kuhn')
      @sylvester = Customer.create!(first_name: 'Sylvester', last_name: 'Braund')
      @heber = Customer.create!(first_name: 'Heber', last_name: 'Nader')
      @dejon = Customer.create!(first_name: 'Dejob', last_name: 'Hoppe')
      @logan = Customer.create!(first_name: 'Logan', last_name: 'Jenkins')

      @invoice_1 = @joey.invoices.create!(created_at: '2023-03-25 09:54:09 UTC')
      @invoice_2 = @joey.invoices.create!(created_at: '2023-04-25 09:54:09 UTC', status: 2)
      @invoice_3 = @cecelia.invoices.create!(created_at: '2023-05-15 09:54:09 UTC', status: 1)
      @invoice_4 = @mariah.invoices.create!(created_at: '2023-05-25 09:54:09 UTC')
      @invoice_5 = @leanne.invoices.create!(created_at: '2023-05-27 09:54:09 UTC')
      @invoice_6 = @sylvester.invoices.create!(created_at: '2023-06-05 09:54:09 UTC', status: 1)
      @invoice_7 = @heber.invoices.create!(created_at: '2023-06-23 09:54:09 UTC')
      @invoice_8 = @dejon.invoices.create!(created_at: '2023-07-15 09:54:09 UTC')
      @invoice_9 = @logan.invoices.create!(created_at: '2023-07-25 09:54:09 UTC')

      @merchant_1 = Merchant.create!(name: 'Schroeder-Jerde')
      @merchant_2 = Merchant.create!(name: 'Klein, Rempel and Jones')

      @item_1 = @merchant_1.items.create!(name: 'Qui Esse',
                                          description: 'Nihil autem sit odio inventore deleniti. Est laudantium ratione distincti', unit_price: 75_107)
      @item_2 = @merchant_1.items.create!(name: 'Autem Minima',
                                          description: 'Sunt officia eum qui molestiae. Nesciunt quidem cupiditate reiciendis est commodi non.', unit_price: 67_076)
      @item_3 = @merchant_1.items.create!(name: 'Ea Voluptatum',
                                          description: 'Voluptate aut labore qui illum tempore eius. Corrupti cum et rerum. Enim illum labore voluptatem dicta consequatur. Consequatur sunt consequuntur ut officiis.', unit_price: 32_301)
      @item_4 = @merchant_1.items.create!(name: 'Nemo Facere',
                                          description: 'Numquam officiis reprehenderit eum ratione neque tenetur. Officia aut repudiandae eum at ipsum doloribus. Iure minus itaque similique. Ratione dicta alias', unit_price: 15_925)
      @item_5 = @merchant_2.items.create!(name: 'Expedita Aliquam',
                                          description: 'Reprehenderit est officiis cupiditate quia eos. Voluptatem illum reprehenderit quo vel eligendi. Et eum omnis id ut aliquid veniam.', unit_price: 31_163)
      @item_6 = @merchant_2.items.create!(name: 'Provident At',
                                          description: 'Reiciendis sed aperiam culpa animi laudantium. Eligendi veritatis sint dolorem asperiores. Earum alias illum eos non rerum.', unit_price: 22_582)
      @item_7 = @merchant_2.items.create!(name: 'Expedita Fuga',
                                          description: 'Voluptatibus omnis quo recusandae distinctio voluptatem quibusdam et. Voluptas odio accusamus delectus sunt quia. Non atque rerum vitae officia odit.', unit_price: 42_629)

      @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 5,
                                            unit_price: 70_000, status: 0)
      @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 6,
                                            unit_price: 69_000, status: 1)
      @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 5,
                                            unit_price: 32_000, status: 2)
      @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 5,
                                            unit_price: 16_000, status: 0)
      @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 5,
                                            unit_price: 19_000, status: 1)
      @invoice_item_6 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_6.id, quantity: 7,
                                            unit_price: 30_000, status: 2)
      @invoice_item_7 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_7.id, quantity: 3,
                                            unit_price: 20_000, status: 0)
      @invoice_item_8 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_8.id, quantity: 7,
                                            unit_price: 45_000, status: 1)
      @invoice_item_9 = InvoiceItem.create!(item_id: @item_7.id, invoice_id: @invoice_9.id, quantity: 4,
                                            unit_price: 56_000, status: 1)

      @transaction_1 = @invoice_1.transactions.create!(credit_card_number: 4_654_405_418_249_632,
                                                       credit_card_expiration_date: '04/27', result: 'success')
      @transaction_2 = @invoice_1.transactions.create!(credit_card_number: 4_654_405_418_249_632,
                                                       credit_card_expiration_date: '04/27', result: 'success')
      @transaction_3 = @invoice_1.transactions.create!(credit_card_number: 4_654_405_418_249_632,
                                                       credit_card_expiration_date: '04/27', result: 'failed')
      @transaction_4 = @invoice_2.transactions.create!(credit_card_number: 4_515_551_623_735_607,
                                                       credit_card_expiration_date: '04/27', result: 'success')
      @transaction_5 = @invoice_2.transactions.create!(credit_card_number: 4_515_551_623_735_607,
                                                       credit_card_expiration_date: '04/27', result: 'failed')
      @transaction_6 = @invoice_3.transactions.create!(credit_card_number: 4_536_896_898_764_278,
                                                       credit_card_expiration_date: '04/27', result: 'success')
      @transaction_7 = @invoice_3.transactions.create!(credit_card_number: 4_536_896_898_764_278,
                                                       credit_card_expiration_date: '04/27', result: 'success')
      @transaction_8 = @invoice_4.transactions.create!(credit_card_number: 4_252_153_331_154_380,
                                                       credit_card_expiration_date: '04/27', result: 'failed')
      @transaction_9 = @invoice_5.transactions.create!(credit_card_number: 4_536_896_898_764_278,
                                                       credit_card_expiration_date: '04/27', result: 'success')
      @transaction_10 = @invoice_5.transactions.create!(credit_card_number: 4_332_881_798_016_631,
                                                        credit_card_expiration_date: '04/27', result: 'success')
      @transaction_11 = @invoice_6.transactions.create!(credit_card_number: 4_920_121_630_073_678,
                                                        credit_card_expiration_date: '04/27', result: 'success')
      @transaction_12 = @invoice_7.transactions.create!(credit_card_number: 4_084_466_070_588_807,
                                                        credit_card_expiration_date: '04/27', result: 'success')
      @transaction_13 = @invoice_7.transactions.create!(credit_card_number: 4_084_466_070_588_807,
                                                        credit_card_expiration_date: '04/27', result: 'success')
      @transaction_14 = @invoice_8.transactions.create!(credit_card_number: 4_993_984_512_460_266,
                                                        credit_card_expiration_date: '04/27', result: 'success')
      @transaction_15 = @invoice_8.transactions.create!(credit_card_number: 4_993_984_512_460_266,
                                                        credit_card_expiration_date: '04/27', result: 'failed')
      @transaction_16 = @invoice_9.transactions.create!(credit_card_number: 4_504_301_557_459_341,
                                                        credit_card_expiration_date: '04/27', result: 'success')
      @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4_504_301_557_459_341,
                                                        credit_card_expiration_date: '04/27', result: 'success')
      @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4_504_301_557_459_341,
                                                        credit_card_expiration_date: '04/27', result: 'success')
      @transaction_17 = @invoice_9.transactions.create!(credit_card_number: 4_504_301_557_459_341,
                                                        credit_card_expiration_date: '04/27', result: 'success')

      visit admin_path
    end

    it 'Has a header indicating that I am on the admin dashboard' do
      expect(page).to have_content('Admin Dashboard', count: 1)
    end

    it 'I see a link to the admin merchants index (/admin/merchants)' do
      expect(page).to have_link 'Merchants', href: admin_merchants_path

      click_link 'Merchants'

      expect(current_path).to eq(admin_merchants_path)
    end

    it 'I see a link to the admin invoices index (/admin/invoices)' do
      expect(page).to have_link 'Invoices', href: admin_invoices_path

      click_link 'Invoices'

      expect(current_path).to eq(admin_invoices_path)
    end

    it 'I see a link to the admin dashboard index(/admin)' do
      visit admin_invoices_path

      expect(page).to have_link 'Dashboard', href: admin_path

      click_link 'Dashboard'

      expect(current_path).to eq(admin_path)
    end

    describe 'top 5 customers who have conducted the largest number of successful transactions' do
      it 'I see the names of the top 5 customers' do
        within('#admin-top-5-customers') do
          expect(@logan.first_name).to appear_before(@joey.first_name)
          expect(@joey.first_name).to appear_before(@heber.first_name)
          expect(@heber.first_name).to appear_before(@cecelia.first_name)
          expect(@cecelia.first_name).to appear_before(@leanne.first_name)

          expect(page).to_not have_content(@mariah.first_name)
          expect(page).to_not have_content(@sylvester.first_name)
          expect(page).to_not have_content(@dejon.first_name)
        end
      end

      it 'I see the number of successful transactions they have conducted' do
        expect(page).to have_content('Logan Jenkins - 4 purchases', count: 1)
        expect(page).to have_content('Joey Ondricka - 3 purchases', count: 1)
        expect(page).to have_content('Heber Nader - 2 purchases', count: 1)
        expect(page).to have_content('Cecelia Osinski - 2 purchases', count: 1)
        expect(page).to have_content('Leanne Kuhn - 2 purchases', count: 1)
      end
    end

    describe 'Incomplete Invoices' do
      it "has a section for listing all the 'Incomplete Invoices'" do
        expect(page).to have_css('.left-half-div')
        expect(page).to have_content('Incomplete Invoices', count: 1)
      end

      it 'lists the ids  of invoices with items not shipped' do
        expect(page).to_not have_content(@invoice_2.id, count: 1)
        expect(page).to_not have_content(@invoice_3.id, count: 1)
        expect(page).to_not have_content(@invoice_6.id, count: 1)

        expect(page).to have_content("Invoice # #{@invoice_1.id}", count: 1)
        expect(page).to have_content("Invoice # #{@invoice_4.id}", count: 1)
        expect(page).to have_content("Invoice # #{@invoice_5.id}", count: 1)
        expect(page).to have_content("Invoice # #{@invoice_7.id}", count: 1)
        expect(page).to have_content("Invoice # #{@invoice_8.id}", count: 1)
        expect(page).to have_content("Invoice # #{@invoice_9.id}", count: 1)
      end

      it 'links to the show page for each invoices' do
        expect(page).to_not have_link("Invoice # #{@invoice_2.id}", count: 1)
        expect(page).to_not have_link("Invoice # #{@invoice_3.id}", count: 1)
        expect(page).to_not have_link("Invoice # #{@invoice_6.id}", count: 1)

        expect(page).to have_link("Invoice # #{@invoice_1.id}", href: admin_invoice_path(@invoice_1), count: 1)
        expect(page).to have_link("Invoice # #{@invoice_4.id}", href: admin_invoice_path(@invoice_4), count: 1)
        expect(page).to have_link("Invoice # #{@invoice_5.id}", href: admin_invoice_path(@invoice_5), count: 1)
        expect(page).to have_link("Invoice # #{@invoice_7.id}", href: admin_invoice_path(@invoice_7), count: 1)
        expect(page).to have_link("Invoice # #{@invoice_8.id}", href: admin_invoice_path(@invoice_8), count: 1)
        expect(page).to have_link("Invoice # #{@invoice_9.id}", href: admin_invoice_path(@invoice_9), count: 1)
      end

      it "For each Invoice, shows the date that the invoice was created - formatted 'Monday, July 18, 2019' " do
        within('#admin-incomplete-invoices') do
          expect(page).to have_content("- #{@invoice_1.created_at.strftime('%A, %b %e %Y')}")
          expect(page).to have_content("- #{@invoice_4.created_at.strftime('%A, %b %e %Y')}")
          expect(page).to have_content("- #{@invoice_5.created_at.strftime('%A, %b %e %Y')}")
          expect(page).to have_content("- #{@invoice_7.created_at.strftime('%A, %b %e %Y')}")
          expect(page).to have_content("- #{@invoice_8.created_at.strftime('%A, %b %e %Y')}")
          expect(page).to have_content("- #{@invoice_9.created_at.strftime('%A, %b %e %Y')}")
        end
      end

      it 'displays the incomplete invoices in order by oldest to newest' do
        expect("Invoice # #{@invoice_1.id}").to appear_before("Invoice # #{@invoice_4.id}")
        expect("Invoice # #{@invoice_4.id}").to appear_before("Invoice # #{@invoice_5.id}")
        expect("Invoice # #{@invoice_5.id}").to appear_before("Invoice # #{@invoice_7.id}")
        expect("Invoice # #{@invoice_7.id}").to appear_before("Invoice # #{@invoice_8.id}")
        expect("Invoice # #{@invoice_8.id}").to appear_before("Invoice # #{@invoice_9.id}")
      end
    end

    describe 'Logo Image from Unsplash' do
      before :each do
        @paths = [
          root_path,
          merchant_dashboard_index_path(@merchant_1),
          merchant_items_path(@merchant_1),
          merchant_invoices_path(@merchant_1),
          admin_path,
          admin_merchants_path,
          admin_invoices_path
        ]
      end

      it 'has a logo image, photo credit, and likes on every page or displays an error message' do
        @paths.each do |path|
          visit path

          if @photos.present?
            expect(page).to have_css('#app-logo img')
            expect(page).to have_css('#app-logo p', text: "Photo Credit: #{photo['user']['name']}")
            expect(page).to have_css('#app-logo p', text: "Likes: #{photo['likes']}")

          else
            @error_message.present?
            expect(page).to have_css('#app-logo p', text: @error_message)
          end
        end
      end
    end
  end
end
