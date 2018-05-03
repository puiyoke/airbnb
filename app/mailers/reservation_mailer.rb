class ReservationMailer < ApplicationMailer
    default from: 'notifications@example.com'
 
    def booking_email(user)
      @user = user
      @url  = 'http://example.com/login'
      mail(to: @user, subject: 'Your booking details')
    end

    def confirmation_email(host)
        @host = host
        @url  = 'http://example.com/login'
        mail(to: @host, subject: "You have a new booking")
     end
end