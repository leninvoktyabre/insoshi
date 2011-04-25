class Link < ActiveRecord::Base
  belongs_to :category
  belongs_to :person
  belongs_to :point
  
  validates_presence_of :url, :title, :description, :person_id, :category_id
  
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
end
