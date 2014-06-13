class IndexController < ApplicationController
  layout 'articles'

  def index
    @promotions = Admin::Article.find_by_title("News & Promotions").html_content
    @travel_guide = Admin::Article.find_by_title("travel_guide").html_content
    @popular_tours_name   = Category.find_by_name("POPULAR TOURS").articles
    @hot_tours_name       = Category.find_by_name("HOT TOURS").articles
    @top_hotel_deals_name = Category.find_by_name("TOP HOTEL DEALS").articles

    render :layout => 'application'
  end

  ['about_company', 'hot_tours', 'hotels', 'car_rental', 'contact_us'].each do |menu|
    define_method(menu) do
      @page_title = menu.gsub(/\_/, " ").titleize
      begin
        @content = Admin::Article.find_by_title(menu).html_content  
      rescue Exception => e
        p @content
      end
      render :template => "index/tour"
    end
  end

  def method_missing(method_id, *arguments, &block)
    if Admin::Article.all.map{|x|x.title.gsub(/ /,"_").downcase}.include?(method_id.to_s)
      self.class.send :define_method, method_id do
        @page_title = method_id.to_s.gsub(/\_/, " ").titleize
        begin
          @content = Admin::Article.find_by_title(method_id).html_content
        rescue Exception => e
          @content = Admin::Article.find_by_title(method_id.to_s.gsub(/\_/, " ").titleize).html_content
        end
        render :template => "index/tour"
      end
      self.send(method_id)
    else
      super
    end
  end
end
