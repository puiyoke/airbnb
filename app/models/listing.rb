class Listing < ApplicationRecord
    #  belongs_to :users
    mount_uploaders :images, ImageUploader
  def index
    @listing = Listing.page(params[:page]).per(10)
  end

  def self.search(search)
    where("country ILIKE ?", "%#{search}%") 
  end
end