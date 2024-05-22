class Board < ApplicationRecord
  belongs_to :user
  has_many :states, dependent: :destroy
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
