# application_controller.rb
class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  set :server, %w[puma]
  set :root, File.dirname(__FILE__)

  configure :development do
    set :database, adapter: 'postgresql',
                   encoding: 'unicode',
                   database: 'phschool_development',
                   pool: 2,
                   username: 'postgres',
                   password: 'Ushuaia2'
  end

  configure :production do
    set :database, adapter: 'postgresql',
                   encoding: 'unicode',
                   database: 'your_database_name',
                   pool: 2,
                   username: 'your_username',
                   password: 'your_password'
  end

  after do
    response.body = response.body.to_json
    response.headers['Content-Type'] = 'application/json'
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
    response.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
  end

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end
end
