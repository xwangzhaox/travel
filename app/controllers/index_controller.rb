class IndexController < ApplicationController
  layout 'articles'

  def index
    @promotions = Admin::Article.find_by_title("News & Promotions").content
    @travel_guide = Admin::Article.find_by_title("travel_guide").content
    @popular_tours_name   = Category.find_by_name("POPULAR TOURS").articles
    @hot_tours_name       = Category.find_by_name("HOT TOURS").articles
    @top_hotel_deals_name = Category.find_by_name("TOP HOTEL DEALS").articles

    render :layout => 'application'
  end

  ['about_company', 'hot_tours', 'hotels', 'car_rental', 'contact_us'].each do |menu|
    define_method(menu) do
      @page_title = menu.gsub(/\_/, " ").upcase
      begin
        @content = Admin::Article.find_by_title(menu).content  
      rescue Exception => e
        p @content
      end
    end
  end
end
