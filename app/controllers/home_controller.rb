class HomeController < ApplicationController
  def index
    @boards = Board.includes(:tasks).last(3)  # Load the last three boards
  end
end
