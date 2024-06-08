class TeamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def join
    current_user.update(team: @team)
    redirect_to teams_path, notice: 'You have joined the team.'
  end

  private  
  def team_params
    params.require(:team).permit(:name, :description)
  end
end
