class GiftType < ActiveRecord::Base
  has_many :gifts
  
  class << self
    def status_list
      {'unconfirmed' => 0, 'active' => 1, 'approval' => 2}
    end
  end
end
