class Listing < ApplicationRecord
    #  belongs_to :users
  def index
    @listing = Listing.page(params[:page]).per(10)
  end
end