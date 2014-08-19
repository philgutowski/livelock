class UserMailer
  def booking_confirmation_email(email)
    recipients email
    from "Shipyard Rehearsals" <notifications@shipyardrehearsals.com>
    subject "Your studio sessions have been booked!"
    sent_on Time.now
    body {email: email}
  end
end
