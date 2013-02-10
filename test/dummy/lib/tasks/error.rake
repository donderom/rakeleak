namespace :rakeleak do
  desc 'Throws a runtime error'
  task :error => :environment do
    nil.x
  end
end
