class Charger
  def initialize(amount_in_cents, email, stripe_token)
    @amount = amount_in_cents
    @email = email
    @stripe_token = stripe_token
  end

  def create

    customer = Stripe::Customer.create(
      email: @email,
      card: @stripe_token
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       @amount,
      description:  'Rails Stripe customer',
      currency:     'usd'
    )

  end
end
