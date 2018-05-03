class ReservationJob < ApplicationJob
  queue_as :default

  def perform(user, host)
    ReservationMailer.booking_email(user.email).deliver
    ReservationMailer.confirmation_email(host.email).deliver
  end
end
