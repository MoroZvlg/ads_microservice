RSpec.describe AdRoutes, type: :request do
  describe 'GET /' do
    before do
      create_list(:ad, 3)
    end

    it 'returns a collection of ads' do
      get '/v1/'

      expect(last_response.status).to eq(200)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /ads (valid auth token)' do
    let(:user_id) { 101 }
    let(:auth_token) { "auth.token" }
    let(:auth_client) { instance_double("Auth Client") }
    let(:geo_client) { instance_double("Geo Client") }

    before do
      allow(auth_client).to receive(:auth).and_return(user_id)
      allow(geo_client).to receive(:geocode).with(String).and_raise(GeoService::Exceptions::GeoException)
      allow(AuthService::Client).to receive(:new).with(token: auth_token).and_return(auth_client)
      allow(GeoService::Client).to receive(:new).and_return(geo_client)
      header "Authorization", "Bearer #{auth_token}"
    end

    context 'missing parameters' do
      it 'returns an error' do
        post '/v1/'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:ad_params) do
        {
            title: 'Ad title',
            description: 'Ad description',
            city: ''
        }
      end

      it 'returns an error' do
        post '/v1/', ad: ad_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
                                               {
                                                   'detail' => 'Fill the City field',
                                                   'source' => {
                                                       'pointer' => '/data/attributes/city'
                                                   }
                                               }
                                           )
      end
    end

    context 'valid parameters' do
      let(:ad_params) do
        {
            title: 'Ad title',
            description: 'Ad description',
            city: 'City',
        }
      end
      let(:last_ad) { Ad.last }


      it 'creates a new ad' do
        expect { post '/v1/', ad: ad_params }
            .to change { Ad.count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an ad' do
        post '/v1/', ad: ad_params

        expect(response_body['data']).to a_hash_including(
                                             'id' => last_ad.id.to_s,
                                             'type' => 'ad'
                                         )
      end
    end

    context "auth client error" do
      before do
        allow(auth_client).to receive(:auth).and_raise(AuthService::Exceptions::AuthException)
      end
      let(:ad_params) do
        {
            title: 'Ad title',
            description: 'Ad description',
            city: 'City',
        }
      end

      it do
        post '/v1/', ad: ad_params

        expect(last_response.status).to eq(403)
        expect(response_body["errors"]).to include({"detail" => I18n.t(:unauthorized, scope: 'api.errors')})
      end
    end
  end

  # describe 'POST /ads (invalid auth token)' do
  #   let(:ad_params) do
  #     {
  #         title: 'Ad title',
  #         description: 'Ad description',
  #         city: 'City'
  #     }
  #   end
  #
  #   it 'returns an error' do
  #     post '/v1/', params: { ad: ad_params }
  #
  #     expect(last_response.status).to eq(403)
  #     expect(response_body['errors']).to include('detail' => 'Доступ к ресурсу ограничен')
  #   end
  # end
end