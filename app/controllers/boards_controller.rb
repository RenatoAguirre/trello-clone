class BoardsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    def index
      @boards = Board.all
    end
  
    def show
      @board = Board.find(params[:id])
    end
  
    def new
      @board = Board.new
    end
  
    def create
      @board = Board.new(board_params)
      if @board.save
        create_basic_states
        redirect_to @board, notice: 'Board was successfully created.'
      else
        render :new
      end    
    end
  
    def edit
      @board = Board.find(params[:id])
    end
  
    def update
      @board = Board.find(params[:id])
      if @board.update(board_params)
        redirect_to @board, notice: 'Board was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @board = Board.find(params[:id])
      @board.destroy
      respond_to do |format|
        format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    private
  
    def board_params
      params.require(:board).permit(:name, :description, :user_id) # List all attributes allowed for mass assignment
    end

    def create_basic_states
      State.new(name: "To Do", board_id: @board.id).save
      State.new(name: "In Progress", board_id: @board.id).save
      State.new(name: "Done", board_id: @board.id).save
    end
  end
