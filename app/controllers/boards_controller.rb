class BoardsController < ApplicationController
  def show
    @board = Board.find(params[:id])
    # You can also include associated states and tasks if needed:
    # @board = Board.includes(:states, :tasks).find(params[:id])
  end
end