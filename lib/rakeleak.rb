require "rakeleak/engine"

module Rakeleak
  def self.tasks
    Rake::Task.tasks
  end

  def self.run(task)
    Rake::Task[task].reenable
    capture_stdout { Rake::Task[task].invoke }
  end

  def self.capture_stdout
    stdout = $stdout
    trap = StringIO.new
    $stdout = trap
    $stdout.sync = true

    yield if block_given?

    trap.string
  ensure
    $stdout = stdout
  end
end
