require "rakeleak/engine"

module Rakeleak
  def self.tasks
    Rake::Task.tasks
  end

  def self.run(params)
    task = params[:id]
    Rake::Task[task].reenable
    capture_stdout { Rake::Task[task].invoke(*args(params)) }
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

  def self.args(params)
    Rake::Task[params[:id]].arg_names.map{|arg| params[arg] }.reject(&:nil?)
  end
end
