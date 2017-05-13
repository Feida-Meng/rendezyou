# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def booking_confirmation_email
    UserMailer.booking_confirmation_email(User.first)
  end
end
