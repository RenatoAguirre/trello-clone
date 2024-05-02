class Board < ApplicationRecord
  belongs_to :user
  has_many :states, dependent: :destroy
  has_many :tasks, through: :states
end
