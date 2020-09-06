require_relative './config/environment'

use Rack::RequestId
use Rack::Ougai::LogRequests, Application.logger

ApplicationLoader.load_app!

map '/ads' do
  run AdRoutes
end


