class SearchesController < ApplicationController
  include ApplicationHelper

  before_filter :login_required

  def index
    
    redirect_to(home_url) and return if params[:q].nil?
    
    #query = params[:q].strip.inspect
    query = params[:q].strip
    model = strip_admin(params[:model])
    page  = params[:page] || 1

    unless %(Person Message ForumPost Pet Advert Catalog).include?(model)
      flash[:error] = "Invalid search"
      redirect_to home_url and return
    end

    if query.blank?
      @search  = [].paginate
      @results = []
    else
      filters = {}
      if model == "Person" and current_person.admin?
        # Find all people, including deactivated and email unverified.
        model = "AllPerson"
      elsif model == "Message"
        filters['recipient_id'] = current_person.id
      end
      
      # @search = Ultrasphinx::Search.new(:query => query, 
      #                                   :filters => filters,
      #                                   :page => page,
      #                                   :class_names => model)
      # @search.run
      # @results = @search.results
      
      if model == 'Pet'  
        @results = Pet.find(:all, :conditions => ['status = 1 AND (name LIKE ? OR description LIKE ?)', '%'+query+'%', '%'+query+'%'])
      elsif model == 'Advert'
        @results = Advert.find(:all, :conditions => ['status = 1 AND (title LIKE ? OR description LIKE ?)', '%'+query+'%', '%'+query+'%'])
      elsif model == 'Catalog'
        @results = Link.find(:all, :conditions => ['status = 1 AND (title LIKE ? OR description LIKE ?)', '%'+query+'%', '%'+query+'%'])
      elsif model == 'Person' or model == 'AllPerson'
        @results = model.classify.constantize.find(:all, :conditions => ['name LIKE ? OR description LIKE ?', '%'+query+'%', '%'+query+'%'])
      elsif model == 'ForumPost'
        @results = Post.find(:all, :conditions => ['type = ? AND (title LIKE ? OR body LIKE ?)', 'ForumPost', '%'+query+'%', '%'+query+'%'])
      end
      
      @results = @results.paginate(:page => params[:page],
                                   :per_page => RASTER_PER_PAGE)
      
      if model == "AllPerson"
        # Convert to people so that the routing works.
        @results.map!{ |person| Person.find(person) }
      end
    end
  rescue Ultrasphinx::UsageError
    flash[:error] = "Invalid search query"
    redirect_to searches_url(:q => "", :model => params[:model])
  end
  
  private
    
    # Strip off "Admin::" from the model name.
    # This is needed for, e.g., searches in the admin view
    def strip_admin(model)
      model.split("::").last
    end
end
