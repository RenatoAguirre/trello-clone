
class HomeController < ApplicationController
  def index
    @latest_boards = Board.includes(:states, :tasks).order('created_at DESC').limit(3)
  end
end
