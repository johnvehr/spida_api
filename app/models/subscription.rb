class Subscription < ApplicationRecord
  belongs_to :account
#  belongs_to :plan

  enum plan_name: [:enterprise,:personal]
end
