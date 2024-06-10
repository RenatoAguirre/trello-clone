class ApplicationController < ActionController::Base
  helper_method :get_team_id_from_name

  add_flash_types :info, :error, :warning
    before_action :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  #boards

  def get_team_ids_from_user(c_user_id) 
    #returns an array of team ids
    team_ids = TeamMember.where(user_id: c_user_id).map { |team_member| team_member.team_id}
    return team_ids
  end
  def get_team_id_from_name(team_name, user_id)
    available_team_ids_for_user = get_team_ids_from_user(user_id)
    team_id = Team.where(id: available_team_ids_for_user).where(name: team_name).first.id
    return team_id
  end

end
