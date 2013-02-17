namespace :rakeleak do
  desc 'Simple task with 2 arguments'
  task :with_args, [:arg1, :arg2] => :environment do |_, args|
    puts args
  end
end
