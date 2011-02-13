class Pet < ActiveRecord::Base
  belongs_to :person
  
  validates_length_of :species, :maximum => 255, :allow_nil => true
  # validates_length_of :title, :maximum => 255, :allow_nil => true
  validates_length_of :description, :maximum => 1000, :allow_nil => true
  validates_presence_of :person_id
  
  def species_list
    ['cat', 'dog']
  end
  
  def sex_list
    ['male', 'female', 'alien']
  end
end
