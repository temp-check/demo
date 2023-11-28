class Temperature < ApplicationRecord
  belongs_to :postal_code
  validates :postal_code_id, presence: true, uniqueness: true
  after_validation :lazy_refresh, if: -> { stale? }

  def lazy_refresh
    if stale?
      weather_api_key = ENV["WEATHER_API_KEY"]
      url = URI("https://api.weatherapi.com/v1/forecast.json?key=#{weather_api_key}&q=#{postal_code.code}&days=10&aqi=no&alerts=no")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)

      response = http.request(request)
      raw = response.read_body
      parsed = JSON.parse(raw)

      if parsed["error"]
        self.forecast = parsed
      
      else
        self.forecast = parsed["forecast"]["forecastday"].map { |day| { "date": day["date"], "max_f": day["day"]["maxtemp_f"], "min_f": day["day"]["mintemp_f"], "max_c": day["day"]["maxtemp_c"], "min_c": day["day"]["mintemp_c"], "icon": day["day"]["condition"]["icon"].gsub("//","https://") } }
        self.update_attribute(:cached, false)
      end
    else
      self.update_attribute(:cached, true)
    end
  end

  def api_error
    if self.forecast.is_a?(Hash) && !self.forecast["error"].nil?
      self.forecast["error"]
    else
      nil
    end
  end

  private

  def stale?
    updated_at && updated_at >= 30.minutes.ago
  end

end
