class RemoveColumnsFirstBoards < ActiveRecord::Migration[7.1]
  def change
    remove_column :boards, :team_id, :integer
  end
end

