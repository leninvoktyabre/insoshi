class Gift < ActiveRecord::Base
  belongs_to :gift_type
  has_many :people
  
end
