class UsersController < ApplicationController
  get '/all' do
    users = User.all
    { users: users.to_a }
  end
end
