class Account < ApplicationRecord
  belongs_to :owner, :class_name => "User", :foreign_key => "user_id",optional: true
  has_many :projects

  has_many :members
  has_many :users, through: :members
  #has_and_belongs_to_many :users
  has_many :invitations
  has_one :subscription

  accepts_nested_attributes_for :subscription

  after_create :update_init_account
  #after_create :create_stripe_customer

  def update_init_account
    self.init_account = true
  end

  def set_stripe_customer_and_subscription(customer,plan)
    chosen_plan = plan['sub_type'] == 'enterprise' ? [0,'plan_GwlvjzIFHVzdNt'] : [1,'plan_GwlwsnbA0dDxyX']
    #[integer, sub_id_string] I use integer for our reference the sub id string is for stripe
    self.update(stripe_customer_id: customer.id)
    retrieved_customer = Stripe::Customer.retrieve(customer.id)
    subscription = Stripe::Subscription.create(
      customer: retrieved_customer.id,
      items: [{plan: chosen_plan[1]}],
      trial_period_days: 7
    )
    Subscription.create(
      account_id: self.id,
      stripe_subscription_id: subscription.id,
      plan_name: chosen_plan[0]
    )

  end
  #def set_subscription
  #  build_plan unless plan.present?
  #end
  def create_stripe_customer(plan)
    Stripe.api_key = ENV['STRIPE_TEST_KEY']
    customer = Stripe::Customer.create({
      description: self.subdomain,
      email: self.owner.email
    })
    set_stripe_customer_and_subscription(customer,plan)
  end

end
