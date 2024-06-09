class Board < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :user
  has_many :states, dependent: :destroy
  has_many :tasks, through: :states

  validates :name, presence: true
  validates :name, uniqueness: { scope: :team_id }
  validates :team_id, presence: true
end
