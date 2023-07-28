@merchant_1 = Merchant.create!(id: 1, name: "Dani")
@merchant_2 = Merchant.create!(name: "Mike")
@item_1 = Item.create!(name: "Apple", description: "This is an apple", unit_price: 1, merchant_id: @merchant_1.id)
@item_2 = Item.create!(name: "Orange", description: "This is an orange", unit_price: 1, merchant_id: @merchant_1.id)
@item_3 = Item.create!(name: "Lemon", description: "This is a lemon", unit_price: 1, merchant_id: @merchant_1.id)
@item_4 = Item.create!(name: "Lime", description: "This is a lime", unit_price: 1, merchant_id: @merchant_2.id)
@merchant_1.items << @item_1
@merchant_1.items << @item_2
@merchant_1.items << @item_3