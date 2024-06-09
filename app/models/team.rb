class Team < ApplicationRecord
  has_many :users, through: :team_members
  has_many :boards

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
