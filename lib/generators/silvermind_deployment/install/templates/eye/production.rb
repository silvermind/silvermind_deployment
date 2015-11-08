app_name = "TODO: YOUR-EYE-APP-NAME"

Eye.config do
  logger "/home/#{app_name}/shared/log/eye.log"

  #mail :host => "mx.some.host", :port => 25, :domain => "some.host"
  #contact :errors, :mail, 'error@some.host'
  #contact :dev, :mail, 'dev@some.host'

end

Eye.application(app_name) do |app|

  working_dir "/home/#{app_name}/current"

  group "services" do

    process :unicorn do
      pid_file "/home/#{app_name}/shared/tmp/pids/unicorn.pid"
      stdall "/home/#{app_name}/shared/log/eye-unicorn.log"
      start_command "bundle exec unicorn -c /home/#{app_name}/current/config/unicorn.rb --daemonize"
      restart_command "kill -USR2 {PID}" # for rolling restarts

      stop_signals [:TERM, 10.seconds]

      #start_timeout 100.seconds
      #restart_grace 50.seconds
    end

    # process :mailer_worker do
    #   working_dir '/home/tailorart/current'
    #   pid_file "/home/tailorart/shared/pids/mailer_worker.pid"
    #   start_command "bundle exec sidekiq -c 2 -q mailer"
    #   daemonize true
    #   stdall "log/eye-mailer_worker.log"
    # end

    # process :default_worker do
    #   pid_file "/home/#{app_name}/shared/tmp/pids/default_worker.pid"
    #   start_command "bundle exec sidekiq -c 1"
    #   daemonize true
    #   stdall "log/eye-default_worker.log"
    # end

    # process :import_worker do
    #   pid_file "/home/#{app_name}/shared/tmp/pids/import_worker.pid"
    #   start_command "bundle exec sidekiq -c 1 -q importer"
    #   daemonize true
    #   stdall "log/eye-import_worker.log"
    # end

    # starts the clockwork which schedule (recurring jobs / cron replacement)
    # process :clock do
    #   pid_file "/home/#{app_name}/shared/tmp/pids/clock.pid"
    #   start_command "bundle exec clockwork config/clock.rb"
    #   daemonize true
    #   stdall "log/eye-clock.log"
    # end

  end

end
