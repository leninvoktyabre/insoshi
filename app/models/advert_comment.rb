class AdvertComment < ActiveRecord::Base
  attr_accessible :body
  
  belongs_to :advert
  belongs_to :person
  belongs_to :commenter, :class_name => "Person",
                         :foreign_key => "commenter_id"
end
