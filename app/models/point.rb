class Point < ActiveRecord::Base
  has_many :adverts 
  has_many :links
  has_many :pets
  has_many :photos
  has_many :people

  POINT_FOR_ADVERT = 10
  POINT_FOR_LINK = 10
  POINT_FOR_PET = 10
  POINT_FOR_PHOTO = 10
  POINT_FOR_PERSON = 10

  class << self
    def add(object, person_id = false)
      #raise object.class.name.inspect
      if object.class.name.to_s == 'Gift'
        gift_type = GiftType.find(object.gift_id)
        value = -gift_type.costs
      else
        value = "#{Point}::POINT_FOR_#{object.class.name.upcase}".constantize
      end

      point = Point.new({:person_id => person_id ? person_id : object.person_id,
           :object => object.class.name,
           :object_id => object.id,
           :value => value})
      point.save
    end

    def remove(object, person_id = false)
      point = Point.find_by_person_id_and_object_and_object_id(person_id ? person_id : object.person_id, object.class.name, object.id)
      point.status = -1
      point.save
    end
    
    def get_points(person)
      points = Point.sum(:value, :conditions => ["person_id = ? AND status = ?", person.id, 1])
    end
    
    def has_points
      
    end
    
  end
end
