require 'net/http'
require 'uri'
require 'json'


MOVIE_API = "https://tmdb.lewagon.com/movie/top_rated"

class GetRequester
  def initialize(url)
    @url = url
  end

  def response_body
    url = URI.parse(@url)
    resp = Net::HTTP.get_response(url)
    JSON.parse(resp.body)
  end
end

def fetch_data
  top_rated_movies_response = GetRequester.new(MOVIE_API)
  top_movies = top_rated_movies_response.response_body
  i = 1

  top_movies['results'].each do |movie|
    movie_title = movie['title']
    movie_image = movie['poster_path']
    movie_overview = movie['overview']
    movie_rating = movie['vote_average']
    Movie.create(title: movie_title, poster_url: movie_image, overview: movie_overview, rating: movie_rating)
    puts "Seeded #{i} movie(s)!"
    i += 1
  end
end

puts '🗑 Clearing database...'

Movie.destroy_all
List.destroy_all
Bookmark.destroy_all

puts '🌱 Seeding data...'

fetch_data

list_names = %w[horror romance action comedy sci-fi cartoon adventure]

i2 = 1

20.times do
  List.create(name: list_names.sample)
  puts "Seeded #{i2} list(s)!"
  i2 += 1
end

i3 = 1
20.times do
  Bookmark.create(comment: 'this is a comment', list_id: (1..10).to_a.sample, movie_id: (1..20).to_a.sample)
  puts "Seeded #{i3} bookmark(s)!"
  i3 += 1
end


puts '✨ All done!'
