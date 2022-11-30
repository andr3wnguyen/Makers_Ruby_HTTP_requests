# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

get '/get-artists' do
  repo = ArtistRepository.new
  listofartists = repo.all
  listofartists.map do |obj| 
    obj.name
  end.join(', ')
end

post '/artists' do
  name = params[:name]
  genre = params[:genre]
  repo = ArtistRepository.new
  artist = Artist.new
  artist.name = 'Wild nothing'
  artist.genre = 'Indie'
  repo.add(artist)
  check = repo.all
  check.map do |obj|
    obj.name
  end.join(',')
end
end