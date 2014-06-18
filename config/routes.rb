Travel::Application.routes.draw do

  namespace :admin do
    root :to => "articles#index"

    get 'category', :controller => 'articles', :action => 'category'
    get 'articles/popular_tours', :controller => 'articles', :action => 'popular_tours'
    get 'articles/hot_tours', :controller => 'articles', :action => 'hot_tours'
    get 'articles/top_hotel_deals', :controller => 'articles', :action => 'top_hotel_deals'
    get 'articles/featured_tours', :controller => 'articles', :action => 'featured_tours'
    get 'articles/category', :controller => 'articles', :action => 'category'
    match 'articles/update_category', :controller => 'articles', :action => 'update_category'

    match 'articles/:id/delete_image/:image_id', :controller => 'articles', :action => 'delete_image', :as => "delete_image"

    resources :articles
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'index#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id))(.:format)'
  mount Ckeditor::Engine => '/ckeditor'
end
