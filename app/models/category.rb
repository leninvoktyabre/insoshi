class Category < ActiveRecord::Base
  has_many :links

  validates_presence_of :title, :parent_id
  
  def to_param    
#    p_id = parent_id
#    path = title
#    categories = Category.all
#    
#    categories.map do |c|
#	  if c.id == p_id
#	    p_id = c.parent_id
#	    path = "#{c.title}-#{path}"
#	    retry
#	  end
#    end
    
    "#{id}-#{title_safe}"
    
  end
  
  def links cat
    Link.find_all_by_category_id(cat)
  end
  
  def all_links cat
    
    #links = Array.new
    #categories = Category.all
    #
    #loop do
    #  links += links(cat.id)
    #  break if cat.parent_id == 0
    #  cat = categories.find_all{|c| c.id == cat.id}
    #end
    #
    #links
    
  end
  
end
