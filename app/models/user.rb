class User < ApplicationRecord
    has_many :boards, dependent: :destroy
    has_many :task_assignments
    has_many :assigned_tasks, through: :task_assignments, source: :task
end
