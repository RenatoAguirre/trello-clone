class BoardsController < ApplicationController
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
  end
