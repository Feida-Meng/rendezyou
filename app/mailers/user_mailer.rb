class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'

  def booking_confirmation_email(user, tour, schedule, tourguide, booking)
    @user = user
    @tour = tour
    @schedule = schedule
    @tour_guide = tourguide
    @booking = booking
    mail(to: @user.email,
         subject: "Booking Confirmation")
  end

  def guide_booking_confirmation_email(tourguide, booking, tour, schedule)
    @tour_guide = tourguide
    @booking = booking
    @tour = tour
    @schedule = schedule
    mail(to: @tour_guide.email,
         subject: "Someone has booked your tour!")
  end

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Rendezyou!")
  end

  def booking_edit_email(user, tour, schedule, tourguide)
    @user = user
    @tour = tour
    @schedule = schedule
    @tour_guide = tourguide
    mail(to: @user.email,
         subject: "Tour Booking Updated")
  end


end
