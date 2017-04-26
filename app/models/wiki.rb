class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :collaborate_users, through: :collaborators, source: :user
  after_initialize :set_default_values, unless: :private
  def set_default_values
      self.private = false
  end
  
  def collaborator?(user)
    collaborate_users.include?(user)
  end
end
