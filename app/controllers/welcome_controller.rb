class WelcomeController < ApplicationController
  def index
    @listing = Listing.paginate(:page => params[:page], :per_page => 9)

  end
end
