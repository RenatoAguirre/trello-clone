class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :boards, dependent: :destroy
  has_many :task_assignments
  has_many :assigned_tasks, through: :task_assignments, source: :task
  #belongs_to :team, through: :team_members
  has_many :team_members
  has_many :teams, through: :team_members 
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_create :create_default_team

  private
    def create_default_team
      team = Team.create!(name: "#{name}'s Team", description: "Default team for #{name}")
      TeamMember.create!(user: self, team: team)
    end
end
