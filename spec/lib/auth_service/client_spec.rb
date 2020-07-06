RSpec.describe AuthService::Client, type: :client do
  subject {described_class.new(connection: auth_connection, token: token)}

  let(:status) { 201 }
  let(:headers) { { "Content-Type" => "application/json" } }
  let(:body) { {} }

  before do
    stubs.post("auth/v1/auth"){ [status, headers, body.to_json] }
  end

  describe "#auth" do
    context "valid token" do
      let(:user_id) { 101 }
      let(:body) { { "meta" => {"user_id" => user_id } } }
      let(:token) { "valid_token" }
      it do
        expect(subject.auth).to eq(user_id)
      end
    end

    context "invalid token" do
      let(:status) { 403 }
      let(:token) { "invalid_token" }

      it do
        expect{subject.auth}.to raise_error(AuthService::Exceptions::AuthException)
      end
    end

    context "nil token" do
      let(:status) { 422 }
      let(:token) { nil }

      it do
        expect{subject.auth}.to raise_error(AuthService::Exceptions::AuthException)
      end
    end
  end
end