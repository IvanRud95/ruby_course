require 'lib/movie'
require 'lib/movie_collection'


module IMDB
  describe MovieCollection do
    let(:movies) { described_class.new('movies.txt') }

    describe '#all' do
      subject { movies.all }
      it { is_expected.to be_an(Array).and have_attributes(count: 250) }
    end

    describe '#by_period' do
      subject { movies.by_period(period) }

      context 'with empty period' do
        let(:period) { nil }
        it { is_expected.to have_attributes(count: 250) }
      end

    
    describe '#filter' do
      subject { movies.filter(facets) }

      context 'empty facet' do
        let(:facets) { {} }
        it { is_expected.to eq(movies.all) }
      end

      context 'by period' do
        let(:period) { :ancient }
        let(:facets) { { period: period } }
        it { expect(subject.map(&:period)).to all(be period) }
      end

      context 'several filters' do
        let(:facets) { { genres: 'Comedy', period: :classic } }
        it { expect(subject.map(&:period)).to all(be :classic) }
        it { expect(subject.map(&:genres)).to all(include('Comedy')) }
      end

      context 'several genres' do
        let(:facets) { { genres: ['Comedy', 'Adventure'] } }
        it { expect(subject.map(&:genres)).to all(include('Comedy').or include('Adventure')) }
      end

      context 'several genres' do
        let(:facets) { { genres: ['Drama', 'Horror'] } }
        it { expect(subject.map(&:genres)).to all(include('Drama').or include('Horror')) }
      end
    end
      describe '#map' do
        subject { movies.map(&:period).uniq }
        it { is_expected.to match_array([:ancient, :classic, :modern, :new]) }
      end

      describe '#select' do
        subject { movies.select { |m| m.title == 'The Terminator' } }
        it { is_expected.to have_attributes(count: 1) }
        its('first.title') { is_expected.to eq('The Terminator') }
      end
    end
  end
end
