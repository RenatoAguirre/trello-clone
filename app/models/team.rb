class Team < ApplicationRecord
  has_many :users
  has_many :boards

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
