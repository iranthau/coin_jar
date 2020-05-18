class Price < ApplicationRecord
  belongs_to :product

  scope :latest, -> { order(created_at: :desc).first }
end
