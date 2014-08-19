class ConfirmationMailer < ActionMailer::Base
  default from: "confirmations@shipyardrehearsals.com"

  def confirmation_email(email)
    mail(to: email, subject: "Confirming your sessions at Shipyard Rehearsals")
  end
end
