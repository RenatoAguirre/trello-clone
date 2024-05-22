class Task < ApplicationRecord
  belongs_to :state
  has_many :task_tags, dependent: :destroy
  has_many :tags, through: :task_tags
  has_many :task_assignments, dependent: :destroy
  has_many :assigned_users, through: :task_assignments, source: :user

  validates :title, presence: true
  validates :description
end