class User < ApplicationRecord
  has_secure_password
  has_many :rides
  has_many :attractions, through: :rides

  def mood
    happiness.to_i > nausea.to_i ? "happy" : "sad"
  end

  def is_admin
    self.admin
  end
end
