require 'active_support/all'

class Movie
  attr_reader :actors, :release_date, :country

  BASE_PRICE = 20
  PREMIUM_ACTORS = ['Sergey Bezrukov']
  PREMIUM_EXTRA_PRICE = 5
  CONTRY_PRICES = {
    'Russia' => 4,
    'UK' => 4,
    'USA' => 2,
    'China' => -2,
    'India' => -2
  }

  def initialize(title:, actors: [], release_date:, country:)
    @title = title
    @actors = actors
    @release_date = release_date
    @country = country
  end

  def price
    result = BASE_PRICE
    result = actor_price_modifier(result)
    result = country_price_modifier(result)
    result = release_date_price_modifier(result)
  end

  private

  def has_premium_actor?
    (actors & PREMIUM_ACTORS).any?
  end

  def country_price_modifier(previous_price)
    previous_price += CONTRY_PRICES.fetch(@country, 0)
  end

  def actor_price_modifier(previous_price)
    previous_price += has_premium_actor? ? PREMIUM_EXTRA_PRICE : 0
  end

  def release_date_price_modifier(previous_price)
    previous_price -= release_date < 1.years.ago ? 10 : 0
  end
end
