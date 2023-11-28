class PostalCode < ApplicationRecord
  has_many :locations
  has_one :temperature, dependent: :destroy

  after_create :create_temperature
  after_update :create_temperature

  def create_temperature
    self.temperature = Temperature.find_or_create_by(postal_code: self)
    self.temperature.lazy_refresh
  end
end
