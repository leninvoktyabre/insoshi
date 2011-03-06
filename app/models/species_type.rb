class SpeciesType < ActiveRecord::Base
  has_many :advert
  has_many :breed_type
  
  class << self
    def status_list
      {'unconfirmed' => 0, 'active' => 1, 'approval' => 2}
    end
  end
end
