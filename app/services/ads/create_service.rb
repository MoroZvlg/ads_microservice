module Ads
  class CreateService
    prepend ApplicationService

    option :ad do
      option :title
      option :description
      option :city
    end

    option :user_id

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      @ad.user_id = user_id
      fetch_coordinates

      if @ad.valid?
        @ad.save
      else
        fail!(@ad.errors)
      end
    end

    def fetch_coordinates
      response = geo_client.geocode(@ad.city, id: @ad.id)
      @ad.lat = response['lat']
      @ad.lon = response['lon']
    rescue ::GeoService::Exceptions::GeoException => e
      pp e.message
    end

    def geo_client
      # GeoRabbitService::Client.fetch
      GeoService::Client.new
    end

  end
end
