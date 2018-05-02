class BraintreeController < ApplicationController

    def new
        @client_token = Braintree::ClientToken.generate
        @reservation = Reservation.find_by(id: params[:id])
        @user = current_user
        @this_reservation = @user.reservations.find_by(id: params[:id])
    end

    def checkout
        @x = Listing.find(Reservation.find(params[:id]).listing_id)
        @days = Reservation.find(params[:id]).check_out - Reservation.find(params[:id]).check_in

        nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

        result = Braintree::Transaction.sale(
         :amount => @x.price.to_i * @days.to_i,
         :payment_method_nonce => nonce_from_the_client,
         :options => {
            :submit_for_settlement => true
          }
         )
      
        if result.success?
          redirect_to :root, :notice => "Transaction successful!"
        else
          redirect_to :root, :notice => "Transaction failed. Please try again."
        end
    end
      
end
  
  