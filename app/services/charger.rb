class Charger
  def initialize(amount_in_cents, email)
    @amount = amount
    @email = email
  end

  def create

    customer = Stripe::Customer.create(
      email: @email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,
      amount:       @amount,
      description:  'Rails Stripe customer',
      currency:     'usd'
    )

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end
