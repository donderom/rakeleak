require "rakeleak/engine"

module Rakeleak
  def self.tasks
    Rake::Task.tasks
  end

  def self.run(task)
    Rake::Task[task].reenable
    Rake::Task[task].invoke
  end
end
