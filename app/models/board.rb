class Board < ApplicationRecord
  belongs_to :user
  has_many :states
  has_many :tasks, through: :states
end
