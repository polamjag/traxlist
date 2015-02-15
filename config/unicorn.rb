# Unicorn PID file location

pid ENV["UNICORN_PID"] unless ENV["UNICORN_PID"].nil?

preload_app true

# Path to logs
#stderr_path "/var/www/traxlist/current/log/unicorn.log"
#stdout_path "/var/www/traxlist/current/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.traxlist.sock"

# Number of processes
worker_processes 2

# Time-out
timeout 30
