module ExchangeRateHelper
  def exchange_rate_between(departure, destination)
    rate = get_exchange_rate_between(departure, destination, Date.today)

    "#{Money.new(100, departure.currency.code).format} = #{Money.new(rate * 100, destination.currency.code).format}"
  end

  def exchange_rate_between_favorable?(departure, destination)
    rate = get_exchange_rate_between(departure, destination, Date.today)
    old_rate = get_exchange_rate_between(departure, destination, (Date.today - 90))

    old_rate >= rate
  end

  private

  def get_exchange_rate_between(departure, destination, date_sampled)
    return 1.0 if ENV['RACK_ENV'] == 'development'

    app.cache "open-exchange-rate-2/#{departure.currency.code},#{destination.currency.code}/#{date_sampled.to_s}" do
      open_exchange_rates_client.exchange_rate(from: departure.currency.code, to: destination.currency.code, on: date_sampled.to_s)
    end
  end

  def open_exchange_rates_client
    @open_exchange_rates_client ||= OpenExchangeRates::Rates.new
  end
end
