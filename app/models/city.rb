class City < ActiveRecord::Base
  has_many :person
  
  class << self
    def status_list
      {'unconfirmed' => 0, 'active' => 1, 'approval' => 2}
    end
  end
end
