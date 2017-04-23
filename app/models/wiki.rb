class Wiki < ActiveRecord::Base

  belongs_to :user
  after_initialize :set_default_values, unless: :private
  def set_default_values
      self.private = false
  end
end
