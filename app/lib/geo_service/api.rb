
module GeoService
  module Api

    def geocode(city, id: nil)
      response = request(method: :get, path: '', params: {city: city})
      response.dig("meta")
    end
  end
end