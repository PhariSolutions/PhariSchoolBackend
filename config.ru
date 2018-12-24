# config.ru
require 'byebug'
require 'sinatra/base'
require 'sinatra/activerecord'

# pull in the helpers and controllers
Dir.glob('./app/{helpers,controllers,models}/*.rb').each { |file| require file }
# pull in the intializers
Dir.glob('./lib/*.rb').each { |file| require file }

# map the controllers to routes
map('/') { run ApplicationController }
map('/users') { run UsersController }
