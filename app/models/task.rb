class Task < ApplicationRecord
  belongs_to :board
  belongs_to :state, optional: true
  belongs_to :user
end
