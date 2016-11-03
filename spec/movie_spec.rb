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
      country: 'Russia'
    }
  end

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
