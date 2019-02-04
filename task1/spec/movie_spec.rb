require 'lib/movie'
require 'lib/movie_collection'

module IMDB
  describe Movie do
    describe '#initialize' do
      let(:movie) { described_class.new(movie_params) }
      subject { movie }
      it do
        is_expected.to have_attributes(
        title: movie_params[:title],
        year: movie_params[:year],
        actors: movie_params[:actors],
        )
      end
    end

    describe '#build' do
      let(:movie) { Movie.build(movie_params_raw.merge(year: year)) }
      subject { movie }

      context 'Movie' do
        let(:year) { '1899' }
        it { is_expected.to be_a(Movie).and have_attributes(year: 1899) }
      end

    

    describe '#to_s' do
      let(:movie) { type.new(movie_params) }

   

    describe '#fit?' do
      let(:movie) { described_class.new(movie_params)}
      subject { movie.fit?(key, value) }

      context 'title' do
        let(:key) { :title }

        context 'fit by string' do
          let(:value) { 'The Shawshank Redemption' }
          it { is_expected.to be true }
        end

        context 'not fit by string' do
          let(:value) { 'The Shawshank' }
          it { is_expected.to be false }
        end

        context 'fit by regexp' do
          let(:value) { /The Shawshank/i }
          it { is_expected.to be true }
        end

        context 'not fit by regexp' do
          let(:value) { /The Terminator/i }
          it { is_expected.to be false }
        end
      end

      context 'year' do
        let(:key) { :year }

        context 'fit by interval' do
          let(:value) { 1993...1995 }
          it { is_expected.to be true }
        end

        context 'not fit by interval' do
          let(:value) { 1993...1994 }
          it { is_expected.to be false }
        end
      end

      context 'actors' do
        let(:key) { :actors }

        context 'fit by string' do
          let(:value) { 'Morgan Freeman' }
          it { is_expected.to be true }
        end

        context 'not fit by string' do
          let(:value) { 'Morgan' }
          it { is_expected.to be false }
        end

        context 'fit by regexp' do
          let(:value) { /Morgan Freeman/i }
          it { is_expected.to be true }
        end
      end

      context 'genres' do
        let(:key) { :genres }

        context 'fit by string' do
          let(:value) { 'Crime' }
          it { is_expected.to be true }
        end

        context 'not fit by string' do
          let(:value) { 'Sci-Fi' }
          it { is_expected.to be false }
        end

        context 'fit by array' do
          let(:value) { ['Sci-Fi', 'Detective'] }
          it { is_expected.to be false }
        end
      end

      context 'period' do
        let(:movie) { ClassicMovie.new(movie_params)}
        let(:key) { :period }

        context 'fit' do
          let(:value) { :classic }
          it { is_expected.to be true }
        end

        context 'not fit' do
          let(:value) { :modern }
          it { is_expected.to be false }
        end
      end
    end

    let(:movie_params) do
      {
        link: "http://imdb.com/title/tt0111161/?ref_=chttp_tt_1",
        title: "The Shawshank Redemption",
        year: 1994,
        country: "USA",
        date: 1994-10-14,
        genres: ['Crime', 'Drama'],
        duration: 142,
        rating: 9.3,
        producer: 'Frank Darabont',
        actors: ['Tim Robbins', 'Morgan Freeman', 'Bob Gunton']
      }
    end

    let(:movie_params_raw) do
      {
        link: "http://imdb.com/title/tt0111161/?ref_=chttp_tt_1",
        title: "The Shawshank Redemption",
        year: "1994",
        country: "USA",
        date: "1994-10-14",
        genres: "Crime,Drama",
        duration: "142 min",
        rating: "9.3",
        producer: "Frank Darabont",
        actors: "Tim Robbins,Morgan Freeman,Bob Gunton"
      }
    end
  end
end
