namespace :rakeleak do
  desc 'Sleeping for 3 seconds and stop'
  task :wait_3_sec => :environment do
    sleep 3
  end
end
