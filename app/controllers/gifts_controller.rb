class GiftsController < ApplicationController
  
  def new
    @gift = Gift.new
    person = Person.find(params[:person])
    @gift.person_id = current_person.id
    @gift.recipient_id = person.id
    @gift.gift_type_id = params[:type].to_i
    @gift.status = 1

    respond_to do |format|
      gift_type = GiftType.find(@gift.gift_type_id)
      if gift_type.costs > Point.get_points(current_person)
        flash[:success] = "Not enough points"
        format.html { redirect_to person_url(person, :anchor => 'tGifts') }
      elsif @gift.save
        Point.add(@gift)
        flash[:success] = "A gift successfully added"
        format.html { redirect_to person_url(person, :anchor => 'tGifts') }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
end
