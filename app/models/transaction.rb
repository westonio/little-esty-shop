class Transaction < ApplicationRecord
  belongs_to :invoice

  validates_presence_of :result, :credit_card_number, :credit_card_expiration_date
end