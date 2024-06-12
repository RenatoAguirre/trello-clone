class TasksController < ApplicationController

  def new
    @task = Task.new
    if params[:state_id]
      @state = State.find(params[:state_id])
    end
  end

  def create
    if params[:state_id] 
      @state = State.find(params[:state_id])
      @state.task = Task.new(task_params)
     
    else
      @task = Task.new(task_params)
    end
    respond_to do |format|
      if @task.save!
        @state = State.find(@task.state_id)
        @board = Board.find(@state.board_id)
        format.html { redirect_to board_url(@board), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      end
    end
  end

  def edit
    @task = Task.find(params[:id])

    if params[:state_id]
      @state = State.find(params[:state_id])
    end
    if params[:board_id]
      @board = Board.find(params[:board_id])
    end
  end

  def update 
    # MUST DO: add user verification, if not added, any user can change any task's state id
    @task = Task.find(params[:id])
    if @task.update(task_params)
      @state = State.find(@task.state_id)
      @board = Board.find(@state.board_id) 
      respond_to do |format|
        #from https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
        #If you are using XHR requests other than GET or POST and redirecting 
        #request method. This may lead to undesirable behavior such as a double DELETE. 
        #To work around this you can return a 303 See Other status code which will be followed using a GET request.
        format.html { redirect_to board_url(@state.board_id), status: 303, notice: 'Task was successfully updated.' }
        format.json { render json: @state, status: :created, location: @state }
      end
    else
      render :edit
    end
  end


  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    respond_to do |format|
      @state = State.find(@task.state_id)
      @board = Board.find(@state.board_id)
      format.html { redirect_to board_url(@board), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private


  def task_params
    params.require(:task).permit(:title, :description, :state_id)
  end
end
