class Plan < ApplicationRecord
  has_many :subscriptions 
  enum plan_title: [:spida_personal,:spida_enterprise]
end
