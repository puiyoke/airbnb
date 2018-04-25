class ListingsController < ApplicationController
    def show
    @listing = Listing.find_by(id: params[:id])
    end

    def verify
        # authorization code
        if current_user.customer?
            flash[:notice] = "Sorry. You are not allowed to perform this action."
            return redirect_to root_path, notice: "Sorry. You do not have the permission to verify a property."
        else
            #need params[:id] to work
            @list = Listing.find_by(id: params[:id])
            @list.verified = true
            @list.save
            return redirect_to root_path, notice: "Okay."
        end
    end
end