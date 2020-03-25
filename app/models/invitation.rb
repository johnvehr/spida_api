class Invitation < ApplicationRecord
  belongs_to :account

  before_create :generate_token

  enum status: [:accepted,:pending]

  def to_param
    token
  end

  def status?
    self.status
  end

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end
end
