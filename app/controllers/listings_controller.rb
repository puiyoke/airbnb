class ListingsController < ApplicationController
    
    def search
        @listing = Listing.all
        if params[:search]
          @listing = Listing.search(params[:search]).order("created_at DESC")
        else
          @listing = Listing.all.order("created_at DESC")
        end
        
    end

    def list
        @listing = Listing.all
    end
    
    def show
        @listing = Listing.find_by(id: params[:id])
    end
    

    def new
        @listing = Listing.new
        respond_to do |format|
            format.html
        end
    end

    def listing_params
        params.require(:listing).permit({images: []}, {remote_images_urls: []}, :remote_images_urls, :name, :property_type, :guest_number, :country, :state, :city, :zipcode, :address, :price, :description, :user_id, :phone)
    end

    def create
        @listing = Listing.new(listing_params)
        @listing.user_id = current_user.id
            if @listing.save
                redirect_to root_path, notice: 'Listing was successfully created.'
            else
                render template: "listings/new"
            end
    end


    def edit
        @listing = Listing.find(params[:id])
    end

    def update
        @listing = Listing.find(params[:id])
        if @listing.user_id == current_user.id
            if @listing.update_attributes(listing_params)
                redirect_back_or root_path
            else
                render 'edit'
            end
        else
            return redirect_to root_path, notice: "Sorry. You do not have the permission to edit the property."
        end
    end

    def reserve
        @host = User.find(Listing.find(params[:id]).user_id)
        @user = current_user
        @reservation = Reservation.new(reserve_params)
        respond_to do |format|
            @reservation.listing_id = params[:id]
            @reservation.user_id = current_user.id
            if @reservation.save
                format.html  { redirect_to users_reservations_url :notice => 'Reservation was successfully made.' }
                ReservationJob.perform_later(@user, @host)

            else
                return redirect_to root_path, notice: "Sorry. Reservation failed. Overlapping reservation exists."
            end
        end
    end

    def reserve_params
        params.require(:reservation).permit(:check_in, :check_out, :user_id, :listing_id)
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

