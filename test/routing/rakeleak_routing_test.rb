require 'test_helper'

module Rakeleak
  class RakeleakRoutingTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test '/tasks routes to tasks#index' do
      assert_routing '/tasks', { controller: 'rakeleak/tasks', action: 'index' }
    end

    test '/tasks/:task/run routes to tasks#run' do
      assert_routing({ path: '/tasks/about/run', method: :post },
                     { controller: 'rakeleak/tasks', action: 'run', id: 'about' })
    end
  end
end
