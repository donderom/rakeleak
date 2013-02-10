require 'test_helper'

module Rakeleak
  class TasksControllerTest < ActionController::TestCase
    include Rake::DSL

    setup do
      @routes = Engine.routes
    end

    test 'should get index' do
      get :index
      assert_response :success
      assert_not_nil assigns(:tasks)
      assert_template :index
    end

    test 'run task' do
      name = 'simple'
      done = false
      Rake::Task.tasks << task(name) {|_| done = true }

      post :run, id: name, format: :json
      assert_response :success
      assert_equal true, done
    end

    test 'return forbidden status if task failed' do
      name = 'error'
      Rake::Task.tasks << task(name) {|_| raise 'boom!' }

      post :run, id: name, format: :json
      assert_response :forbidden
    end

    test 'return error description if task failed' do
      name = 'error'
      message = 'boom!'
      Rake::Task.tasks << task(name) {|_| raise message }

      post :run, id: name, format: :json
      json = JSON.parse(response.body)
      assert_not_nil json['error']
      assert_equal message, json['error']['msg']
      assert_not_nil json['error']['stacktrace']
    end
  end
end
