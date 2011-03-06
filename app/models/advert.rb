class Advert < ActiveRecord::Base
  belongs_to :person
  belongs_to :category
  belongs_to :city
  belongs_to :deal_type
  belongs_to :species_type
  belongs_to :sex_type
  belongs_to :breed_type
  
  has_many :advert_comments
  
  validates_presence_of :deal_id, :species_id, :sex_id, :price, :title, :description, :person_id, :city_id
  
  def deal_list
    ['sell', 'buy', 'exchange', 'gifts']
  end
  
  def species_list
    ['cat', 'dog', 'any']
  end
  
  def sex_list
    ['male', 'female', 'any']
  end
  
  def comments
    AdvertComment.find(:all, :conditions => ["advert_id = ?", id], :order => "created_at DESC")
  end
    
end
