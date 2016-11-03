require_relative './spec_helper'
require_relative '../lib/movie'

describe Movie do
  subject(:movie) { Movie.new attributes }

  let(:attributes) { default_attributes }
  let(:default_attributes) do
    {
      title: 'Some Movie',
      release_date: 3.years.ago,
      actors: ['Steven Seagal', 'Arnold Schwarzenegger', 'Robert De Niro'],
      country: 'Poland'
    }
  end

  let(:usa_attributes) { default_attributes.merge({ country: 'USA'}) }
  let(:russia_attributes) { default_attributes.merge({ country: 'Russia' }) }

  it { is_expected.to be_a(Movie) }

  it 'has 3 actors' do
    expect(movie.actors.size).to eq 3
  end

  it 'has a release date' do
    expect(movie.release_date).to be_a Time
  end

  it 'has a contry' do
    expect(movie.country).to be_a String
  end

  context 'test movie' do
    let(:base_movie) { Movie.new(default_attributes) }
    let(:russian_movie) { Movie.new(russia_attributes) }
    let(:usa_movie) { Movie.new(usa_attributes) }

    it { expect(russian_movie.price).to eq (base_movie.price + 4) }
    it { expect(usa_movie.price).to eq (base_movie.price + 2) }

  end

  context 'older than a year' do
    before do
      default_attributes.merge!({release_date: 2.years.ago})
    end

    it 'costs $10' do
      expect(movie.price).to eq 10
    end

    it 'costs $5 more if actors include Bezrukov' do
      default_attributes[:actors] << 'Sergey Bezrukov'
      expect(movie.price).to eq 15
    end
  end

  context 'newer than a year' do
    before do
      default_attributes.merge!({release_date: 1.month.ago})
    end

    it 'costs $20' do
      expect(movie.price).to eq 20
    end

    it 'costs $5 more if actors include Bezrukov' do
      default_attributes[:actors] << 'Sergey Bezrukov'
      expect(movie.price).to eq 25
    end
  end
end
