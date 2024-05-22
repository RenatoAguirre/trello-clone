class User < ApplicationRecord
    has_many :boards, dependent: :destroy
    has_many :task_assignments
    has_many :assigned_tasks, through: :task_assignments, source: :task

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
