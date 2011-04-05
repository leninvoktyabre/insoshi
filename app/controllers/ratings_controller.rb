class RatingsController < ApplicationController
  def set_rating
    @object = params[:object].to_s
    @object_id = params[:object_id].to_i
    value = 1 if params[:value] == 'yes'
    value = -1 if params[:value] == 'no'
    
    @has_vote = Rating.find_by_person_id_and_object_and_object_id(current_person.id,
                                                        @object,
                                                        @object_id)
    
    if logged_in? and @object.classify.constantize.find(@object_id) and !@has_vote
      rating = Rating.new({:person_id => current_person.id,
                   :object => @object,
                   :object_id => @object_id,
                   :value => value})
    end
    
    if @has_vote or (rating and rating.save)
      render :partial => 'thanks'
    else
      render :nothing => true
    end
  end
  
  def get_rating
    object = params[:object].to_s
    object_id = params[:object_id].to_i
    
    @votes = Rating.find_all_by_object_and_object_id(object, object_id)
    @rating = @votes.map{|r| @rating + r.value}
  end
end
