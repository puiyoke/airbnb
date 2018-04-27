class SearchController < ApplicationController
    def index
      @listings = Listing.search(params[:search])
    end
  end