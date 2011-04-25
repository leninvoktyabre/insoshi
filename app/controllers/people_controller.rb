class PeopleController < ApplicationController
  
  skip_before_filter :require_activation, :only => :verify_email
  skip_before_filter :admin_warning, :only => [ :show, :update ]
  before_filter :login_required, :only => [ :show, :edit, :update,
                                            :common_contacts ]
  before_filter :correct_user_required, :only => [ :edit, :update ]
  before_filter :setup
  
  def index
    @people = Person.mostly_active(params[:page])

    respond_to do |format|
      format.html
    end
  end
  
  def show
    @person = Person.find(params[:id])
    #raise @person.inspect
    unless @person.active? or current_person.admin?
      flash[:error] = "That person is not active"
      redirect_to home_url and return
    end
    if logged_in?
      @some_contacts = @person.some_contacts
      page = params[:page]
      @common_contacts = current_person.common_contacts_with(@person,
                                                             :page => page)
      # Use the same max number as in basic contacts list.
      num_contacts = Person::MAX_DEFAULT_CONTACTS
      @some_common_contacts = @common_contacts[0...num_contacts]
      @blog = @person.blog
      @posts = @person.blog.posts.paginate(:page => params[:page])
      @galleries = @person.galleries.paginate(:page => params[:page])
      @guests = @person.guests
      @pets = @person.pets
      
      #@points = Point.sum(:value, :conditions => ["person_id = ? AND status = ?", current_person.id, 1])
      @gift_types = GiftType.find_all_by_status(1)
      @gifts = Gift.find_all_by_status_and_recipient_id(1, @person.id)
      
    end
    respond_to do |format|
      format.html
    end
  end

  def new
    @body = "register single-col"
    @person = Person.new
    @cities = City.find(:all)

    respond_to do |format|
      format.html
    end
  end

  def create
    # raise params[:person].inspect
    cookies.delete :auth_token
    
    @person = Person.new(params[:person])
    @cities = City.find(:all)
    
    respond_to do |format|
      @person.email_verified = false if global_prefs.email_verifications?
      @person.identity_url = session[:verified_identity_url]
      
      if params[:person]['newcity'].length == 0
        @person.city_id = params[:person]['city_id']
      else
        @new_city = City.new({:title => params[:person]['newcity'], :status => 0})
        @new_city.save
        @person.city_id = @new_city.id
        # todo: letter for admin about a new city
      end
      
      @person.save
      Point.add(@person, @person.id)
      if @person.errors.empty?
        session[:verified_identity_url] = nil
        if global_prefs.email_verifications?
          @person.email_verifications.create
          flash[:notice] = %(Thanks for signing up! Check your email
                             to activate your account.)
          format.html { redirect_to(home_url) }
        else
          self.current_person = @person
          flash[:notice] = "Thanks for signing up!"
          format.html { redirect_back_or_default(home_url) }
        end
      else
        @body = "register single-col"
        format.html { if @person.identity_url.blank? 
                        render :action => 'new'
                      else
                        render :partial => "shared/personal_details.html.erb", :object => @person, :layout => 'application'
                      end
                    }
      end
    end
  rescue ActiveRecord::StatementInvalid
    # Handle duplicate email addresses gracefully by redirecting.
    redirect_to home_url
  rescue ActionController::InvalidAuthenticityToken
    # Experience has shown that the vast majority of these are bots
    # trying to spam the system, so catch & log the exception.
    warning = "ActionController::InvalidAuthenticityToken: #{params.inspect}"
    logger.warn warning
    redirect_to home_url
  end

  def verify_email
    verification = EmailVerification.find_by_code(params[:id])
    if verification.nil?
      flash[:error] = "Invalid email verification code"
      redirect_to home_url
    else
      cookies.delete :auth_token
      person = verification.person
      person.email_verified = true; person.save!
      self.current_person = person
      flash[:success] = "Email verified. Your profile is active!"
      redirect_to person
    end
  end

  def edit
    @person = Person.find(params[:id])
    @cities = City.find(:all)
    
    respond_to do |format|
      format.html
    end
  end

  def update
    @person = Person.find(params[:id])
    @cities = City.find(:all)
    
    respond_to do |format|
      case params[:type]
      when 'info_edit'
        
        # if params[:person]['newcity'].length == 0
        #   @person.city_id = params[:person]['city_id']
        # else
        #   @new_city = City.new({:title => params[:person]['newcity'], :status => 0})
        #   @new_city.save
        #   @person.city_id = @new_city.id
        #   # todo: letter for admin about a new city
        # end
        
        if !preview? and @person.update_attributes(params[:person])
          flash[:success] = 'Profile updated!'
          format.html { redirect_to(@person) }
        else
          if preview?
            @preview = @person.description = params[:person][:description]
          end
          format.html { render :action => "edit" }
        end
      when 'password_edit'
        if @person.change_password?(params[:person])
          flash[:success] = 'Password changed.'
          format.html { redirect_to(@person) }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end
  
  def common_contacts
    @person = Person.find(params[:id])
    @common_contacts = @person.common_contacts_with(current_person,
                                                    :page => params[:page])
    respond_to do |format|
      format.html
    end
  end
  
  private

    def setup
      @body = "person"
    end
  
    def correct_user_required
      redirect_to home_url unless Person.find(params[:id]) == current_person
    end
    
    def preview?
      params["commit"] == "Preview"
    end
end
