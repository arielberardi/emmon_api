class User < ActiveRecord::Base
  extend Devise::Models 
  include DeviseTokenAuth::Concerns::User
  
  before_create :set_default_role!

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: { maximum: 255 }

  belongs_to :role, optional: true
  belongs_to :department, optional: true

  has_many :tasks
  has_many :user_historicals
  has_many :user_teams
  has_many :teams, through: :user_teams

  private

  def set_default_role! 

    unless Role.count == 0
      if self.role == nil 
        self.role = Role.find_by(name: DEFAULT_ROLES[:employee])
      end
    end
  end

end
