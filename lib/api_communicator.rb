require "rest-client"
require "json"
require "pry"

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get("http://www.swapi.co/api/people/")
  response = JSON.parse(all_characters)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
  results_array = response["results"]
  film_array = []

  results_array.each do |character_hash|
    if character_hash["name"].downcase == character
      character_hash["films"].each do |film_url|
        film_array << film_url
      end
    end
  end
  final_film_array = film_array.uniq
  parsed_films = []
  final_film_array.each do |url|
    film_request = RestClient.get("#{url}")
    parsed_film_request = JSON.parse(film_request)
    parsed_films << parsed_film_request
  end
  parsed_films
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
