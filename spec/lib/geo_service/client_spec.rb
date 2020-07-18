RSpec.describe GeoService::Client, type: :client do
  subject {described_class.new(connection: auth_connection)}

  let(:status) { 201 }
  let(:headers) { { "Content-Type" => "application/json" } }
  let(:body) { {} }

  before do
    stubs.get("geo/v1/"){ [status, headers, body.to_json] }
  end

  describe "#auth" do
    context "known city" do
      let(:city) {"City"}
      let(:body) { { "meta" => {"lat" => 40.to_d, "lon" => 30.to_d } } }
      it do
        expect(subject.geocode(city)).to eq({"lat" => 40.to_d.to_s, "lon" => 30.to_d.to_s })
      end
    end

    context "unknown city" do
      let(:city) {"City"}
      let(:status) { 404 }
      let(:body) { { "errors" => [] } }

      it do
        expect{subject.geocode(city)}.to raise_error(GeoService::Exceptions::GeoException)
      end
    end

  end
end