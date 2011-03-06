class Link < ActiveRecord::Base
  belongs_to :category
  belongs_to :person
  
  validates_presence_of :url, :title, :description, :person_id, :category_id
end
