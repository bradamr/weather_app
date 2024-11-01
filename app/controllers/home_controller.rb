class HomeController < ApplicationController
  def index
    @address = Address.new
  end

  def results
    response = Faraday.get(search_weather_forecasts_url) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = { address: address_params }.to_json
    end

    @results = JSON.parse(response.body)

    respond_to do |fmt|
      fmt.turbo_stream
      fmt.html { redirect_to root_path }
    end
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :zip)
  end
end
