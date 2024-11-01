class WeatherForecastsController < ApplicationController
  def search
    address = Address.new(address_params)
    unless address.valid?
      render json: {
        error: "Please provide a valid address: #{address.errors.full_messages.join(', ')}"
      }, status: :bad_request
      return
    end

    @cache_miss = false

    @weather_forecast = Rails.cache.fetch(address.cache_key, expires_in: 5.minutes) do
      @cache_miss = true
      WeatherForecast.new
    end

    render json: { forecast: @weather_forecast, cached: !@cache_miss }
  rescue StandardError => e
    render json: {
      error: 'There was an error retrieving the current forecast. Please try again.'
    }, status: :bad_request
  end

  private

  def address_params
    params.require(:address).permit(:street, :city, :state, :zip)
  end
end
