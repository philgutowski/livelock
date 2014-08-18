class Charger
  def initialize(time_slots, email, stripe_token)
    @time_slots = time_slots
    @email = email
    @stripe_token = stripe_token
  end

  def create
   customer =  Stripe::Customer.create(
      email: @email,
      card: @stripe_token
    )

    Stripe::Charge.create(
      customer:     customer.id,
      amount:       '1000',
      description:  'Studio Customer',
      currency:     'usd'
    )

  end
end
