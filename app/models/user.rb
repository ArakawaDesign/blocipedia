class User < ActiveRecord::Base
  has_many :wikis, dependent: :destroy
  has_many :collaborators
  has_many :collaborated_wikis, through: :collaborators, source: :wiki
  
  before_save { self.role ||= :member }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
         
  enum role: [:member, :admin, :premium]
end
