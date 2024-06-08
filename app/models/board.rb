class Board < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :user
  has_many :states, dependent: :destroy
  has_many :tasks, through: :states

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
