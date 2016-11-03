require 'active_support/all'

class Movie
  attr_reader :actors, :release_date, :country

  PREMIUM_ACTORS = ['Sergey Bezrukov']
  PREMIUM_EXTRA_PRICE = 5

  def initialize(title:, actors: [], release_date:, country:)
    @title = title
    @actors = actors
    @release_date = release_date
    @country = country
  end

  def price
    has_premium_actor? ? base_price + PREMIUM_EXTRA_PRICE : base_price
  end

  private

  def base_price
    release_date < 1.years.ago ? 10 : 20
  end

  def has_premium_actor?
    (actors & PREMIUM_ACTORS).any?
  end
end
