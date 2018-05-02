class Listing < ApplicationRecord
    #  belongs_to :users
    has_many :reservation
    mount_uploaders :images, ImageUploader
  def index
    @listing = Listing.page(params[:page]).per(9)
  end

  def self.search(search)
    where("country ILIKE ? OR city ILIKE ?", "%#{search}%", "%#{search}%") 
  end
end