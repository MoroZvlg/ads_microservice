module GeoRabbitService
  module Api

    def geocode(city, id: nil)
      payload = {id: id, city: city}.to_json

      publish_and_wait(payload, type: "geocode")
    end

  end
end