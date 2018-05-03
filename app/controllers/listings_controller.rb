class ListingsController < ApplicationController
    def show
        @listing = Listing.find_by(id: params[:id])
    end

    def new
        @listing = Listing.new
        respond_to do |format|
            format.html  # new.html.erb
        end
    end


    def create
        @listing = Listing.new(listing_params)
        respond_to do |format|
            @listing.user_id = current_user.id
            if @listing.save
                format.html  { redirect_to listings_new_url :notice => 'Listing was successfully created.' }
            else
                format.html  { render :action => "new" }
            end
        end
    end

    def listing_params
            params.require(:listing).permit({images: []}, :name, :property_type, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id)
    end

    def show
        @listing = Listing.find(params[:id]) 
        respond_to do |format|
          format.html  # show.html.erb
        end
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