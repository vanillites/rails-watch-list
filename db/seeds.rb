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

list_names = %w[Horror Romance Action Comedy Sci-fi Cartoon Adventure]

i2 = 1

List.create(name: list_names[0], photo_url: "https://images.unsplash.com/photo-1516410529446-2c777cb7366d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=987&q=80")
puts "Seeded 1 list!"

List.create(name: list_names[1], photo_url: "https://images.unsplash.com/photo-1474552226712-ac0f0961a954?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80")
puts "Seeded 2 lists!"

List.create(name: list_names[2], photo_url: "https://images.unsplash.com/photo-1541492845268-2c3c2765dc58?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2071&q=80")
puts "Seeded 3 lists!"

List.create(name: list_names[3], photo_url: "https://images.unsplash.com/photo-1543584756-8f40a802e14f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80")
puts "Seeded 4 lists!"

List.create(name: list_names[4], photo_url: "https://images.unsplash.com/photo-1543083115-638c32cd3d58?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2832&q=80")
puts "Seeded 5 lists!"

List.create(name: list_names[5], photo_url: "https://images.unsplash.com/photo-1580477667995-2b94f01c9516?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80")
puts "Seeded 6 lists!"

List.create(name: list_names[6], photo_url: "https://images.unsplash.com/photo-1631641551258-98cea9aedd91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80")
puts "Seeded 7 lists!"



i3 = 1
20.times do
  Bookmark.create(comment: 'this is a comment', list_id: (1..6).to_a.sample, movie_id: (1..20).to_a.sample)
  puts "Seeded #{i3} bookmark(s)!"
  i3 += 1
end


puts '✨ All done!'
