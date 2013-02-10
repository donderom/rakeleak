require_dependency "rakeleak/application_controller"

module Rakeleak
  class TasksController < ApplicationController
    def index
      @tasks = Rakeleak.tasks
    end

    def run
      respond_to do |format|
        begin
          Rakeleak.run(params[:id])
          format.json { render json: true }
        rescue => e
          response = {
            error: {
              msg: e.to_s,
              stacktrace: e.backtrace.join("\n").to_s
            }
          }
          format.json { render json: response, status: :forbidden }
        end
      end
    end
  end
end
