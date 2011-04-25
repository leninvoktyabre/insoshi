ActionController::Routing::Routes.draw do |map|
 
  #map.filter :locale

  map.resources :events, :member => { :attend => :get, 
                                      :unattend => :get } do |event|
    event.resources :comments
  end

  map.resources :preferences
  map.resources :searches
  map.resources :activities
  map.resources :connections
  map.resources :password_reminders
  map.resources :photos,
                :member => { :set_primary => :put, :set_avatar => :put }
  map.open_id_complete 'session', :controller => "sessions",
                                  :action => "create",
                                  :requirements => { :method => :get }
  map.resource :session
  map.resource :galleries
  
  map.connect 'ratings/get_rating/:object/:object_id', :controller => 'ratings',
                                   :action => 'get_rating'
  map.connect 'ratings/set_rating/:object/:object_id/:value', :controller => 'ratings',
                                   :action => 'set_rating'
  
  map.connect 'pets/get_breed/:id', :controller => 'pets',
                                   :action => 'get_breed'
  
  map.resources :pets
  map.resources :adverts
  map.resources :cities
  map.resources :deal_types
  map.resources :species_types
  map.resources :sex_types
  map.resources :breed_types
  map.resources :gifts do |g|
    g.resources :people
  end
  map.resources :gift_types do |gt|
    gt.resources :gifts
  end
  #map.resources :categories
  map.resources :messages, :collection => { :sent => :get, :trash => :get },
                           :member => { :reply => :get, :undestroy => :put }

  map.resources :people, :member => { :verify_email => :get,
                                      :common_contacts => :get }
  map.connect 'people/verify/:id', :controller => 'people',
                                   :action => 'verify_email'
    
  map.resources :people do |person|
     person.resources :messages
     person.resources :galleries
     person.resources :connections
     person.resources :comments
     person.resources :pets
     person.resources :adverts
     person.resources :gifts
  end
      
  map.resources :catalogs
  #map.resources :links
  map.resources :categories do |category|
    category.resources :links
  end

  #map.match 'catalogs/*id', :controller => 'catalogs', :action => 'show'
    
  map.resources :adverts do |advert|
    advert.resources :advert_comments
  end
    
  map.resources :galleries do |gallery|
    gallery.resources :photos
  end
  
  map.connect 'admin/categories/get_subcat/:id', :controller => 'categories',
                                   :action => 'get_subcat'
  
  map.namespace :admin do |admin|
    admin.resources :people, :preferences
    admin.resources :settings
    admin.resources :cities, :deal_types, :species_types, :sex_types, :breed_types
    admin.resources :categories
    admin.resources :gift_types
    admin.resources :forums do |forums|
      forums.resources :topics do |topic|
        topic.resources :posts
      end
    end    
  end
    
  map.resources :blogs do |blog|
    blog.resources :posts do |post|
        post.resources :comments
    end
  end

  map.resources :forums do |forums|
    forums.resources :topics do |topic|
      topic.resources :posts
    end
  end
  
  map.signup '/signup', :controller => 'people', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.home '/', :controller => 'home'
  map.about '/about', :controller => 'home', :action => 'about'
  map.admin_home '/admin/home', :controller => 'home'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
  

end
