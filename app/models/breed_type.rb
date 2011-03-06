class BreedType < ActiveRecord::Base
  has_many :advert
  belongs_to :species_type
  
  class << self
    def status_list
      {'unconfirmed' => 0, 'active' => 1, 'approval' => 2}
    end
  end
end
