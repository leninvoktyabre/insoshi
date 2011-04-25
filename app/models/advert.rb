class Advert < ActiveRecord::Base
  belongs_to :person
  belongs_to :city
  belongs_to :deal_type
  belongs_to :species_type
  belongs_to :sex_type
  belongs_to :breed_type
  belongs_to :point
  
  has_many :advert_comments
  
  validates_presence_of :deal_id, :species_id, :sex_id, :price, :title, :description, :person_id, :city_id
  
  def comments
    AdvertComment.find(:all, :conditions => ["advert_id = ?", id], :order => "created_at DESC")
  end

end 
