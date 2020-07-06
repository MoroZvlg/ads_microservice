class AdRoutes < Application
  helpers PaginationLinks, Auth
  namespace '/v1' do
    get '/' do
      page = params[:page].presence || 1
      ads = Ad.reverse_order(:updated_at)
      ads = ads.paginate(page.to_i, Settings.pagination.default_per_page)

      serializer = AdSerializer.new(ads.all, links: pagination_links(ads))

      status 200
      json serializer.serializable_hash
    end

    post '/' do
      ad_params = validate_with!(PermitParams::NewAd)

      result = Ads::CreateService.call(ad: ad_params[:ad], user_id: user_id)
      if result.success?
        data = AdSerializer.new(result.ad)

        status 201
        json data.serializable_hash
      else
        status 422
        error_response(result.ad || result.errors)
      end
    end
  end
end
