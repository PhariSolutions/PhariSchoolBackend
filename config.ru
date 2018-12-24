# config.ru
require 'sinatra/base'

# pull in the helpers
Dir.glob('./app/helpers/*.rb').each { |file| require file }
# pull in the controllers
Dir.glob('./app/controllers/*.rb').each { |file| require file }
# pull in the intializers
Dir.glob('./lib/initialiazers/*.rb').each { |file| require file }
# loading configurations
Dir.glob('./config/boot.rb').each { |file| require file }

# map the controllers to routes
map('/') { run ApplicationController }
