class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def booking_confirmaion_email(user)
    @user = user
    mail(to: @user.email,
         subject: "Booking Confirmation")
  end
end
