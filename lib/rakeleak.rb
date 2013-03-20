require "rakeleak/engine"

module Rakeleak
  def self.tasks
    Rake::Task.tasks
  end

  def self.run(params)
    task_name = params[:id]
    Rake::Task[task_name].reenable

    task = -> { capture_stdout { Rake::Task[task_name].invoke(*args(params)) } }
    if params[:env].present? && (params[:env] =~ /\A\S+\s*=\s*.+/) == 0
      with_env(params[:env]) { task.call }
    else
      task.call
    end
  end

  private

  def self.with_env(env)
    key, value = env.strip.split(/\s*=\s*/)
    prev_value = ENV[key]
    ENV[key] = value

    yield
  ensure
    prev_value.nil? ? ENV.delete(key) : ENV[key] = prev_value
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
