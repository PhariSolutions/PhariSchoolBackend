# Change to match your CPU core count
workers 2
# Min and Max threads per worker
threads 1, 6

app_dir = File.expand_path('../..', __FILE__)
shared_dir = "#{app_dir}/shared"
# Default to production
env = ENV['RACK_ENV'] || 'development'
environment env

# Set up socket location
if env == 'development'
  bind 'tcp://0.0.0.0:3000'
else
  bind 'tcp://0.0.0.0:80'
end

# Logging
stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true if env == 'production'

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
# activate_control_app
