class WeatherForecast
  attr_accessor :low, :high, :current

  def initialize
    generate_forecast
  end

  private

  def generate_forecast
    @low = rand(0..20)
    @high = rand(20..100)
    @current = rand(low..high)
  end
end
