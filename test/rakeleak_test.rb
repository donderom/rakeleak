require 'test_helper'

class RakeleakTest < ActiveSupport::TestCase
  include Rake::DSL

  test 'loading available rake tasks' do
    Rails.application.load_tasks
    assert_equal Rake::Task.tasks.size, Rakeleak.tasks.size
  end

  test 'running existing task' do
    name = 'simple'
    Rake::Task.tasks << task(name) {|_| 'eval this string and stop' }
    assert_nothing_raised { Rakeleak.run(name) }
  end

  test 'running existing task throwing exception' do
    name = 'exception'
    message = 'simple exception'
    Rake::Task.tasks << task(name) {|_| raise message }
    assert_raise(RuntimeError) { Rakeleak.run(name) }
  end
end
