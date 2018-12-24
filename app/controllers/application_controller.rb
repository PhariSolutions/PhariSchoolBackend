# application_controller.rb
class ApplicationController < Sinatra::Base
  helpers ApplicationHelper

  # set folder for templates to ../views, but make the path absolute
  # set :views, File.expand_path('../../views', __FILE__)
  set :server, %w[puma]
  set :root, File.dirname(__FILE__)
  # set :run, false

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

  # don't enable logging when running tests
  configure :production, :development do
    enable :logging
  end
end
