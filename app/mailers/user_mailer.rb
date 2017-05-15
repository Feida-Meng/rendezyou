class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'

  def booking_confirmation_email(user, tour, schedule, tourguide)
    @user = user
    @tour = tour
    @schedule = schedule
    @tour_guide = tourguide
    mail(to: @user.email,
         subject: "Booking Confirmation")
  end

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Rendezyou!")
  end

end
