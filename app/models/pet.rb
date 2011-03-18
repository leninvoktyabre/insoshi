class Pet < ActiveRecord::Base
  belongs_to :person
  
  has_many :photos, :dependent => :destroy, :order => 'created_at'

  validates_length_of :description, :maximum => 1000, :allow_nil => true
  validates_presence_of :person_id, :name, :species_id, :sex_id, :breed_id
  
  class << self
    def status_list
      {'unconfirmed' => 0, 'active' => 1}
    end
  end
  
  ## Photo helpers
  
  def photo
    # This should only have one entry, but use 'first' to be paranoid.
    photos.find_all_by_avatar(true).first
  end

  # Return all the photos other than the primary one
  def other_photos
    photos.length > 1 ? photos - [photo] : []
  end

  def main_photo
    photo.nil? ? "default.png" : photo.public_filename
  end

  def thumbnail
    photo.nil? ? "default_thumbnail.png" : photo.public_filename(:thumbnail)
  end

  def icon
    photo.nil? ? "default_icon.png" : photo.public_filename(:icon)
  end

  def bounded_icon
    photo.nil? ? "default_icon.png" : photo.public_filename(:bounded_icon)
  end

  # Return the photos ordered by primary first, then by created_at.
  # They are already ordered by created_at as per the has_many association.
  def sorted_photos
    # The call to partition ensures that the primary photo comes first.
    # photos.partition(&:primary) => [[primary], [other one, another one]]
    # flatten yields [primary, other one, another one]
    @sorted_photos ||= photos.partition(&:primary).flatten
  end
  
  def to_param
    "#{id}-#{name.to_safe_uri}"
  end
  
end
