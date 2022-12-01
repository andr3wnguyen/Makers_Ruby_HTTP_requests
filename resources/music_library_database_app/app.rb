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

  get '/' do
    return erb(:index)
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
  artist.name = name
  artist.genre = genre
  repo.create(artist)
  check = repo.all
  check.map do |obj|
    obj.name
  end.join(', ')
end


post '/name' do
  @name = params[:name]
  return erb(:index)
end

get '/helloname' do
  @name = params[:name]
  return erb(:index)
end

get '/albums' do
  album_repo = AlbumRepository.new
  @albums = album_repo.all

  return erb(:albums)
end

get '/albums/:id' do
  id = params[:id]
  album_repo = AlbumRepository.new
  found = album_repo.find(id)
  @albumtitle = found.title
  @albumrelease = found.release_year
  return erb(:albumid)
end

get '/artists/:id' do
  id = params[:id]
  repo = ArtistRepository.new
  @result = repo.find(id)
  return erb(:artists)
end

get '/artists' do
  repo = ArtistRepository.new
  @artists = repo.all
  return erb(:artistsid)
end
end
