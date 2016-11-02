require 'active_support/all'

class Movie
  attr_reader :actors, :release_date
  
  def initialize(title:, actors: [], release_date:)
    @title = title
    @actors = actors
    @release_date = release_date
  end
  
  PREMIUM_ACTORS = ['Sergey Bezrukov']
  PREMIUM_EXTRA_PRICE = 5
  
  def price
    has_premium_actor? ? base_price + PREMIUM_EXTRA_PRICE : base_price
  end
  
  private
  
  def base_price
    if release_date < 1.years.ago
      10
    else
      20
    end
  end
  
  def has_premium_actor?
    (actors & PREMIUM_ACTORS).any?
  end
end
