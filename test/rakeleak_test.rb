require 'test_helper'
require 'ostruct'

class RakeleakTest < ActiveSupport::TestCase
  include Rake::DSL

  test 'loading available rake tasks' do
    Rails.application.load_tasks
    assert_equal Rake::Task.tasks.size, Rakeleak.tasks.size
  end

  test 'running existing task' do
    Rake::Task.tasks << task(:simple) {|_| 'eval this string and stop' }
    assert_nothing_raised { Rakeleak.run(id: :simple) }
  end

  test 'running existing task throwing exception' do
    Rake::Task.tasks << task(:exception) {|_| raise 'simple exception' }
    assert_raise(RuntimeError) { Rakeleak.run(id: :exception) }
  end

  test '.capture_stdout captures simple output by $stdout.puts' do
    message = 'Hello, World'
    out = Rakeleak.capture_stdout { puts message }
    assert_equal "#{message}\n", out
  end

  test '.capture_stdout captures any output by $stdout.puts' do
    numbers = [1,2,3]
    out = Rakeleak.capture_stdout { numbers.each {|number| puts number } }
    assert_equal "#{numbers.join("\n")}\n", out
  end

  test '.capture_stdout captures output by p' do
    object = OpenStruct.new
    object.x, object.y = 1, 2
    out = Rakeleak.capture_stdout { p object }
    assert_equal "#{object}\n", out
  end

  test '.capture_stdout returns nothing if there is no output to stdout' do
    assert_equal '', Rakeleak.capture_stdout { true }
  end

  test '.capture_stdout returns nothing if there is no block given' do
    assert_equal '', Rakeleak.capture_stdout
  end

  test '.capture_stdout throws an exception from block' do
    assert_raise(RuntimeError) { Rakeleak.capture_stdout { raise 'any exception' } }
  end

  test 'loading rake task arguments' do
    Rake::Task.tasks << task(:args, [:arg1, :arg2])
    assert_equal [:foo, :bar], Rakeleak.args(id: :args, arg1: :foo, arg2: :bar)
  end

  test 'filtering rake task arguments if there is no any' do
    Rake::Task.tasks << task(:filtered_args, [:arg1, :arg2])
    assert_equal [], Rakeleak.args(id: :filtered_args, some_value: 1)
  end

  test 'running task with arguments' do
    Rake::Task.tasks << task(:with_args, [:arg1, :arg2]) {|_, args| puts "#{args[:arg1]}#{args[:arg2]}" }
    assert_equal "foobar\n", Rakeleak.run(id: :with_args, arg1: 'foo', arg2: 'bar')
  end

  test 'passing new environment variable' do
    key = 'RAKELEAK'
    Rake::Task.tasks << task(:with_new_env_var) { assert_equal 'value', ENV[key] }
    Rakeleak.run(id: :with_new_env_var, env: "#{key}=value")
    assert_equal false, ENV.include?(key)
  end

  test 'passing existing environment variable' do
    key = 'RAKELEAK'
    value = 'value'
    ENV[key] = value
    Rake::Task.tasks << task(:with_env_var) { assert_equal 'new value', ENV[key] }
    Rakeleak.run(id: :with_env_var, env: "#{key}=new value")
    assert_equal true, ENV.include?(key)
    assert_equal value, ENV[key]
    ENV.delete(key)
  end

  test 'passing empty environment variable' do
    res = :pending
    Rake::Task.tasks << task(:with_empty_env_var) { res = :done }
    Rakeleak.run(id: :with_empty_env_var, env: '')
    assert_equal :done, res
  end

  test 'passing incorrect environment variable' do
    res = :pending
    Rake::Task.tasks << task(:with_incorrect_env_var) { res = :done }
    Rakeleak.run(id: :with_incorrect_env_var, env: 'RAKELEAK')
    assert_equal :done, res
  end
end
