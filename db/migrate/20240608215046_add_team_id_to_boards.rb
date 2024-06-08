class AddTeamIdToBoards < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :team_id, :integer
    add_index :boards, :team_id
  end
end
