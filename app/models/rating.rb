class Rating < ActiveRecord::Base
  has_many :pets
  has_many :people
  
  class << self

    def remove(object)
      ratings = Rating.find_all_by_object_and_object_id(object.class.name, object.id)
      ratings.map{|r| r.destroy}
    end
  
  end
end
