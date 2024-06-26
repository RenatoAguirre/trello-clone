class BoardsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    helper_method :statesForTaskDropdown
    def index
      if !user_signed_in?
        #the last user its a dummy user created in the seed file, so no real user
        @boards= get_available_boards(User.last.id)
      else
        @team_board_dict = get_team_board_dict_from_user(current_user.id)
      end
    end
  
    def show
      @board = Board.find(params[:id])
      if !is_user_allowed_to_see_board(current_user.id, @board.id)
        redirect_to boards_path, notice: "You're not allowed to see this board."
      end
      @board_states = @board.states.order(created_at: :asc)
    end
  
    def new
      @board = Board.new
    end
  
    def create
      @board = Board.new(board_params)
      if @board.save
        create_basic_states
        respond_to do |format|
          format.html { redirect_to board_path(@board), notice: 'Board was successfully created.' }
          format.json { render json: @board, status: :created }
        end
      else
        respond_to do |format|
          format.html { render :new, status: :unprocessable_entity}
          format.json { render json: @board.errors, status: :unprocessable_entity }
        end
      end    
    end
  
    def edit 
      @board = Board.find(params[:id])
      if !is_user_allowed_to_see_board(current_user.id, @board.id)
        redirect_to boards_path, notice: "You're not allowed to see this board."
      end
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
      params.require(:board).permit(:name, :description, :user_id, :team_id) # List all attributes allowed for mass assignment
    end

    def create_basic_states
      State.new(name: "To Do", board_id: @board.id).save
      State.new(name: "In Progress", board_id: @board.id).save
      State.new(name: "Done", board_id: @board.id).save
    end

    def get_available_boards(user_id) #returns an array of boards
      teams = TeamMember.where(user_id: user_id)
      boards = []
      teams.each do |team|
        boards.concat(Board.where(team_id: team.team_id))
      end
      return boards
    end

    def get_team_names_from_user(user_id) 
      #returns an array of team names
      team_ids = get_team_ids_from_user(user_id)
      team_names = Team.where(id: team_ids).map { |team| team.name}
      return team_names
    end
    def get_team_board_dict_from_user(user_id) 
      #returns a  dictionary of keys: team_name and values: list(boards)
      team_ids = get_team_ids_from_user(user_id)
      team_names = Team.where(id: team_ids).map { |team| [team.id, team.name]}.to_h
      team_board_dicts = team_ids.map { |team_id| [team_names[team_id], Board.where(team_id: team_id)]}.to_h
      return team_board_dicts
    end

    def is_name_valid_within_team(name, team_id)
      return Board.where(team_id: team_id, name: name).empty?
    end

    def is_user_allowed_to_see_board(user_id, board_id)
      board = Board.find(board_id)
      team_id = board.team_id
      team_member = TeamMember.where(user_id: user_id, team_id: team_id)
      return !team_member.empty?
    end
    
    def statesForTaskDropdown(task_id)
      task = Task.find(task_id)
      board = Board.find(task.state.board_id)
      states = board.states
      states = board.states.reject { |state| state.id == task.state.id }
      return states
    end

  end 
