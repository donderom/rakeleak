require 'test_helper'
require 'ostruct'

class RakeleakTest < ActiveSupport::TestCase
  include Rake::DSL

  test 'loading available rake tasks' do
    Rails.application.load_tasks
    assert_equal Rake::Task.tasks.size, Rakeleak.tasks.size
  end

  test 'running existing task' do
    name = :simple
    Rake::Task.tasks << task(name) {|_| 'eval this string and stop' }
    assert_nothing_raised { Rakeleak.run(name) }
  end

  test 'running existing task throwing exception' do
    name = :exception
    message = 'simple exception'
    Rake::Task.tasks << task(name) {|_| raise message }
    assert_raise(RuntimeError) { Rakeleak.run(name) }
  end

  test '::capture_stdout captures simple output by $stdout.puts' do
    message = 'Hello, World'
    out = Rakeleak.capture_stdout { puts message }
    assert_equal "#{message}\n", out
  end

  test '::capture_stdout captures any output by $stdout.puts' do
    numbers = [1,2,3]
    out = Rakeleak.capture_stdout { numbers.each {|number| puts number } }
    assert_equal "#{numbers.join("\n")}\n", out
  end

  test '::capture_stdout captures output by p' do
    object = OpenStruct.new
    object.x, object.y = 1, 2
    out = Rakeleak.capture_stdout { p object }
    assert_equal "#{object}\n", out
  end

  test '::capture_stdout returns nothing if there is no output to stdout' do
    assert_equal '', Rakeleak.capture_stdout { true }
  end

  test '::capture_stdout returns nothing if there is no block given' do
    assert_equal '', Rakeleak.capture_stdout
  end

  test '::capture_stdout throws an exception from block' do
    assert_raise(RuntimeError) { Rakeleak.capture_stdout { raise 'any exception' } }
  end

end
