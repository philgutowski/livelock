Rails.configuration.stripe = {
  publishable_key: ENV.fetch('PUBLISHABLE_KEY'),
  secret_key: ENV.fetch('SECRET_KEY')
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
