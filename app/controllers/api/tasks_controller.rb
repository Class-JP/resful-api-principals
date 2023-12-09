class Api::TasksController < ApplicationController
  before_action :set_task, only: %i[ show update destroy ]
  before_action :auth_user

  # GET /tasks
  def index
    @tasks = Task.all

    render json:  @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy!

    render json: {message: 'Task deleted!'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      begin
        @task = Task.find(params[:id])
      rescue => error
        Rails.logger.error('****** Task Cannot Be Found! ******')
        @error_message = {
          message: 'Task not found! The ID is not present!'
        }

        render json: @error_message, status: :not_found
      end
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :description, :completed)
    end
end
