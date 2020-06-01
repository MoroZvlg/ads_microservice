class MicroApplication < Sinatra::Base

  get '/' do
    json AdSerializer.new(Ad.all)
  end

  post '/' do
    ad = Ad.create(**ads_params)
    json AdSerializer.new(ad)
  rescue => e
    pp e.message
    pp e.backtrace
    json success: false, error: e.message
  end


  private

  def current_user
    find_user || raise_not_found_error
  end

  def find_user
    @user ||= User[params[:user_id]]
  end

  def raise_not_found_error
    raise 'User not found'
  end

  def ads_params
    {
        title: params[:title],
        description: params[:description],
        user: current_user
    }
  end

end