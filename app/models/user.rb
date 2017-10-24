class User < ApplicationRecord
  include Clearance::User
  include AASM

  SITUATIONS = ['I move in', 'I built a new flat/house', 'I need a temporary access']

  validates :first_name, :last_name, :street_number, :street_name, :zip_code, :city, presence: true, if: -> { aasm_state == 'step' }
  validates :situation, :pdl, presence: true, if: -> { aasm_state == 'end' }
  validates :situation, inclusion: { in: SITUATIONS }, if: -> { aasm_state == 'end' }
  validates :pdl,  numericality: { only_integer: true }, length: { is: 14 }, if: -> { aasm_state == 'end' }

  aasm do
    state :start, initial: true
    state :step
    state :end

    event :fill_general_informations do
      transitions from: :start, to: :step
    end

    event :fill_technical_informations do
      transitions from: :step, to: :end
    end

    event :back_to_general_informations do
      transitions from: :step, to: :start
    end
  end
end
