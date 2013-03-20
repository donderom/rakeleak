namespace :rakeleak do
  desc 'Testing environment variables'
  task :env => :environment do
    p ENV['RAKELEAK']
  end
end
