class StatesController < ApplicationController
  def index
    @states = State.all
    if params[:board_id]
      @board = Board.find(params[:board_id])
    end
  end
  def show
    @state = State.find(params[:id])
  end

  def new
    @state = State.new
    if params[:board_id]
      @board = Board.find(params[:board_id])
    end
  end

  def create
    if params[:board_id]
      @board = Board.find(params[:board_id])
      @board.state = State.new(state_params)
    else 
      @state = State.new(state_params)
    end
      respond_to do |format|
        if @state.save!
          #@board = Board.find(params[:board_id])
          format.html { redirect_to board_url(@state.board_id), notice: "Comment was successfully created." }
          format.json { render :show, status: :created, location: @state }
        end
      end
  end

  def edit
    @state = State.find(params[:id])
    if params[:board_id]
      @board = Board.find(params[:board_id])
    end
  end

  def update
    @state = State.find(params[:id])
    if @state.update(state_params)
      redirect_to board_url(@state.board_id), notice: 'State was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @state = State.find(params[:id])
    @state.destroy
    respond_to do |format|
      format.html { redirect_to board_url(@state.board_id), notice: 'State was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def state_params
    params.require(:state).permit(:name, :board_id)
  end
end
