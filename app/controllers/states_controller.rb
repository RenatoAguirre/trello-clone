class StatesController < ApplicationController
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
    if @state.save!
      #@board = Board.find(params[:board_id])
      respond_to do |format|
        format.html { redirect_to board_url(@state.board_id), status: 303, notice: "Comment was successfully created." }
        format.json { render json: @state, status: :created, location: @state }
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
      respond_to do |format|
        #from https://api.rubyonrails.org/classes/ActionController/Redirecting.html#method-i-redirect_to
        #If you are using XHR requests other than GET or POST and redirecting 
        #request method. This may lead to undesirable behavior such as a double DELETE. 
        #To work around this you can return a 303 See Other status code which will be followed using a GET request.
        format.html { redirect_to board_url(@state.board_id), status: 303, notice: 'State was successfully updated.' }
        format.json { render json: @state, status: :created, location: @state }
      end
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
