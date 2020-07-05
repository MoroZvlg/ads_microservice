require_relative './config/environment'

ApplicationLoader.load_app!

map '/ads' do
  run AdRoutes
end


