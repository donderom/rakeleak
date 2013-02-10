namespace :rakeleak do
  desc "Lorem ipsum dolor sit amet, consectetur adipiscing elit Nulla varius nibh sit amet nulla faucibus eget vehicula tortor viverra Ut mattis dolor quis neque blandit viverra Fusce volutpat auctor sem nec blandit Suspendisse egestas pharetra erat vel pellentesque Sed in posuere sapien"
  task :timerror => :environment do
    if DateTime.now.minute % 2 == 0
      raise "Lorem ipsum dolor sit amet, consectetur adipiscing elit Nulla varius nibh sit amet nulla faucibus eget vehicula tortor viverra Ut mattis dolor quis neque blandit viverra Fusce volutpat auctor sem nec blandit Suspendisse egestas pharetra erat vel pellentesque Sed in posuere sapien"
    end
  end
end
