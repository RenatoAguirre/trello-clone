class State < ApplicationRecord
    belongs_to :board
    has_many :tasks, dependent: :destroy

    validates :name, presence: true, uniqueness: { scope: :board_id }
end
