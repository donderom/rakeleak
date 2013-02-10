require 'rake'

module Rakeleak
  class Engine < ::Rails::Engine
    isolate_namespace Rakeleak

    initializer "rakeleak.load_tasks" do
      Rake::Task.clear
      Rake::TaskManager.record_task_metadata = true
      Rails.application.load_tasks
    end
  end
end
