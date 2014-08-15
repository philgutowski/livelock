class Charger
  def initialize(time_slots, email, stripe_token)
    @time_slots = time_slots
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
      amount:       '1000',
      description:  'Studio Customer',
      currency:     'usd'
    )

  end

  private

  def cost_of_bookings
    number_of_time_slots = @time_slots.count
    number_of_time_slots * 25 *100
  end
end
