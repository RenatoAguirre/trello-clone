class Board < ApplicationRecord
  belongs_to :user
  has_many :states, dependent: :destroy
end
