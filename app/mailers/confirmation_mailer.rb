class ConfirmationMailer < ActionMailer::Base
  default from: "livelock@heroku.com"

  def confirmation_email(email)
    mail(to: email, subject: "Confirming your session(s) at Shipyard Rehearsals")
  end
end
