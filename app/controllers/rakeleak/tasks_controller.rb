require_dependency "rakeleak/application_controller"

module Rakeleak
  class TasksController < ApplicationController
    def index
      @tasks = Rakeleak.tasks
    end

    def run
      respond_to do |format|
        begin
          output = Rakeleak.run(params)
          format.json { render json: { output: output } }
        rescue => e
          response = {
            msg: e.to_s,
            stacktrace: e.backtrace.join("\n").to_s
          }
          format.json { render json: response, status: :forbidden }
        end
      end
    end
  end
end
