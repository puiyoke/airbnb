class Reservation < ApplicationRecord
    belongs_to :listing
    belongs_to :user
    validates :listing_id, :uniqueness => {scope: :check_in}
    validate :reservations_must_not_overlap
    


      private
      
      def reservations_must_not_overlap
        return if self
                    .class
                    .where.not(id: id)
                    .where(listing_id: listing_id)
                    .where('check_in < ? AND check_out > ?', check_out, check_in)
                    .none?
      end

end