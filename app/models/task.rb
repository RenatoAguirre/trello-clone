class Task < ApplicationRecord
  belongs_to :board
  belongs_to :state, optional: true
end
