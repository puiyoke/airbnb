class WelcomeController < ApplicationController
  def index
    @listing = Listing.all
  end
end
