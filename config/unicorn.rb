# Set the working application directory
working_directory "/home/traxlist/traxlist"

# Unicorn PID file location
pid "/home/traxlist/traxlist/pids/unicorn.pid"

# Path to logs
stderr_path "/home/traxlist/traxlist/log/unicorn.log"
stdout_path "/home/traxlist/traxlist/log/unicorn.log"

# Unicorn socket
listen "/tmp/unicorn.traxlist.sock"

# Number of processes
worker_processes 2

# Time-out
timeout 30
