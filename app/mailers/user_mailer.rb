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

  def booking_edit_email(user, tour, schedule, tourguide, booking)
    @user = user
    @tour = tour
    @schedule = schedule
    @tour_guide = tourguide
    @booking = booking
    mail(to: @user.email,
         subject: "Tour Booking Updated")
  end

  def guide_booking_edit_email(tourguide, booking, tour, schedule)
    @tour_guide = tourguide
    @booking = booking
    @tour = tour
    @schedule = schedule
    mail(to: @tour_guide.email,
         subject: "Someone has updated their booking")

  end

  def guide_cancel_booking_email(tourguide, booking, tour, schedule)
    @tour_guide = tourguide
    @booking = booking
    @tour = tour
    @schedule = schedule
    mail(to: @tour_guide.email,
         subject: "Someone has cancelled their booking")
  end

  def cancel_schedule_email(tourists, schedule, tour)
    @tourists = tourists
    @schedule = schedule
    @tour = tour
    emails = @tourists.collect(&:email).join(",")
    mail(to: emails, subject: "Tour Cancellation")
  end
  #
  # def request_replacement(shift)
  #   @shift = shift
  #   @user = shift.user
  #   @recipients = User.where(:replacement_emails => true)
  #   @url  = root_url
  #   emails = @recipients.collect(&:email).join(",")
  #   mail(:to => emails, :subject => "A replacement clerk has been requested")
  # end


end
