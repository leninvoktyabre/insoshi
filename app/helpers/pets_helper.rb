module PetsHelper
  # Link to a person (default is by name).
  def pet_link(text, pet = nil, html_options = nil)
    if pet.nil?
      pet = text
      text = pet.name
    elsif pet.is_a?(Hash)
      html_options = pet
      pet = text
      text = pet.name
    end
    # We normally write link_to(..., pet) for brevity, but that breaks
    # activities_helper_spec due to an RSpec bug.
    link_to(h(text), pet, html_options)
  end
end
