
module GeoService
  module Api

    def geocode(city)
      response = request(method: :get, path: '', params: {city: city})
      response.dig("meta")
    end
  end
end