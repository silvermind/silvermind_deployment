# Setup paths
if ENV['RACK_ENV'] == 'development'
  puts "wrong for production!!!!!!!!"
  #web_root = File.expand_path('tmp')
  current_path = File.expand_path(File.join(File.dirname(__FILE__), '..'))
else
  web_root = File.expand_path(File.join(File.dirname(__FILE__), '..', '..'))
  current_path = File.join(web_root, 'current')
end

shared_path = File.join(web_root, 'shared')
pid_file = File.join(shared_path, 'tmp/pids', 'unicorn.pid')

HttpRequest::DEFAULTS["rack.url_scheme"] = "http"
HttpRequest::DEFAULTS["HTTPS"] = "off"
HttpRequest::DEFAULTS["HTTP_X_FORWARDED_PROTO"] = "http"


# Configuration
worker_processes 2
timeout 30 # restarts workers that hang for 30 seconds
preload_app true # faster worker spawn time and needed for newrelic. http://newrelic.com/docs/troubleshooting/im-using-unicorn-and-i-dont-see-any-data
pid pid_file
listen File.join(shared_path, 'tmp/sockets', 'unicorn.sock'), :backlog => 1024 # default = 1024
working_directory current_path

stderr_path File.join(shared_path, 'log', 'unicorn.stderr.log')
stdout_path File.join(shared_path, 'log', 'unicorn.stdout.log')


before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{current_path}/Gemfile"
end


# Zero downtime deployment
# Kill old process as the new finished spinning up
before_fork do |server, worker|
  old_pid = "#{pid_file}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      old_pid_content = File.read(old_pid).to_i
      Process.kill("QUIT", old_pid_content)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end
