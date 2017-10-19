class User < ApplicationRecord
  include Clearance::User

  SITUATIONS = ['I move in', 'I built a new flat/house', 'I need a temporary access']

  validates :first_name, :last_name, :street_number, :street_name, :zip_code, :city, :situation, :pdl, presence: true
  validates :situation, inclusion: { in: SITUATIONS }
  validates :pdl,  numericality: { only_integer: true }, length: { is: 14 }
end
