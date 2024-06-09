class TeamsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
    @boards = @team.boards
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      TeamMember.create!(user: current_user, team: @team)
      respond_to do |format|
        format.html { redirect_to @team, notice: 'Team was successfully created.'}
        format.json { render json: @team, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    @team = Team.find(params[:id])
    if !current_user.teams.include?(@team)
      TeamMember.create!(user: current_user, team: @team)
      redirect_to teams_path, notice: "You have joined the team."
    else 
      redirect_to teams_path, notice: "You've already joined part of that team."
    end
  end

  def leave
    @team = Team.find(params[:id])
    if @team == current_user.teams.last
      redirect_to teams_path, notice: "You can't leave your default team."
    elsif current_user.teams.include?(@team)
      TeamMember.find_by(user: current_user, team: @team).destroy
      redirect_to teams_path, notice: "You have left the team."
    else
      redirect_to teams_path, notice: "You're not part of that team."
    end
  end

  private  
  def team_params
    params.require(:team).permit(:name, :description)
  end
end
