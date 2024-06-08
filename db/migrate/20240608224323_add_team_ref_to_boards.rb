class AddTeamRefToBoards < ActiveRecord::Migration[7.1]
  def change
    add_reference :boards, :team, null: false, foreign_key: true
  end
end
