class Location < ApplicationRecord
  belongs_to :postal_code, optional: true
  validates :address, presence: true, uniqueness: true, if: -> { !geocode_error.nil? || !lat.nil? || !lng.nil? }
  
  geocoded_by :address, latitude: :lat, longitude: :lng
  after_validation :lazy_geocode, if: -> { address.present? && address_changed?}

  reverse_geocoded_by :lat, :lng do |obj, results|
    if geo = results.first
      obj.postal_code_id = PostalCode.find_or_create_by(code: geo.postal_code).id
    end
  end

  GEOCODER_SERVICE_UNAVAILABLE = "Geocoder Error: Please try again later.".freeze
  GEOCODER_SERVICE_INVALID_API_KEY = "Geocoder Error: Invalid API key.".freeze
  GEOCODER_ADDRESS_NOT_FOUND = "Address not found.".freeze
  def self.search(query)
    where("address ILIKE ?", "%#{query}%")
  end

  private

  def lazy_geocode
    begin
      geocode
      reverse_geocode
      # If we can't geocode the address because it's invalid, we don't want to retry, otherwise present errors so user can retry
      raise Geocoder::InvalidRequest if lat.blank? || lng.blank?
    rescue SocketError
      self.errors.add(:address, GEOCODER_SERVICE_UNAVAILABLE)
    rescue Timeout::Error
      self.errors.add(:address, GEOCODER_SERVICE_UNAVAILABLE)
    rescue Geocoder::OverQueryLimitError
      self.errors.add(:address, GEOCODER_SERVICE_UNAVAILABLE)
    rescue Geocoder::RequestDenied
      self.errors.add(:address, GEOCODER_SERVICE_UNAVAILABLE)
    rescue Geocoder::InvalidRequest
      self.geocode_error = GEOCODER_ADDRESS_NOT_FOUND
    rescue Geocoder::InvalidApiKey
      self.errors.add(:address, GEOCODER_SERVICE_INVALID_API_KEY)
    rescue Geocoder::ServiceUnavailable
      self.errors.add(:address, GEOCODER_SERVICE_UNAVAILABLE)
    end
  end
end
