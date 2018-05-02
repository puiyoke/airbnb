class BraintreeController < ApplicationController

    def new
        @client_token = Braintree::ClientToken.generate
        @reservation = Reservation.find_by(id: params[:id])
        @user = current_user
        @this_reservation = @user.reservations.find_by(id: params[:id])
    end

    def checkout


        nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
      
        result = Braintree::Transaction.sale(
         :amount => "10.00",
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
  
  