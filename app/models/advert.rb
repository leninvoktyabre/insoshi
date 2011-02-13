class Advert < ActiveRecord::Base
  belongs_to :person
  has_many :advert_comments 
  
  validates_presence_of :deal, :species, :sex, :price, :title, :description, :person_id
  
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
