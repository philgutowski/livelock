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
      customer: customer.id,
      amount: total_prices,
      description: 'Studio Customer',
      currency: 'usd'
    )
  end

  def total_prices
    total_price = 0
    @time_slots.each do |time_slot|
      start_date = time_slot.started_at
      time_slot_creator = TimeSlotCreator.new
      unit_price = time_slot_creator.price_for(start_date)
      total_price += unit_price
    end
    total_price
  end
end
