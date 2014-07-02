class IndexController < ApplicationController
  layout 'articles'

  def index
    @promotions = Admin::Article.find_by_title("News & Promotions").html_content
    @travel_guide = Admin::Article.find_by_title("travel_guide").html_content
    @popular_tours_name   = Category.find_by_name("POPULAR TOURS").sub_categories
    @hot_tours_name       = Category.find_by_name("HOT TOURS").articles
    @top_hotel_deals_name = Category.find_by_name("TOP HOTEL DEALS").articles

    render :layout => 'application'
  end

  ['about_company', 'hot_tours', 'hotels', 'car_rental', 'contact_us'].each do |menu|
    define_method(menu) do
      @page_title = menu.gsub(/\_/, " ").titleize
        begin
          @article = Admin::Article.find_by_format_title(menu)
        rescue Exception => e
          @article = Admin::Article.find_by_format_title(menu.to_s.gsub(/\_/, " ").titleize)
        end
      render :template => "index/tour"
    end
  end

  def method_missing(method_id, *arguments, &block)
    if Admin::Article.all.map{|x|x.title.gsub(/ /,"_").downcase}.include?(method_id.to_s)
      self.class.send :define_method, method_id do
        @page_title = method_id.to_s.gsub(/\_/, " ").titleize
        begin
          @article = Admin::Article.find_by_format_title(method_id)
        rescue Exception => e
          @article = Admin::Article.find_by_format_title(method_id.to_s.gsub(/\_/, " ").titleize)
          @other_tourist_route = @article.categories.first.articles.select{|x|x.format_title!=method_id}
        end
        render :template => "index/tour"
      end
      self.send(method_id)
    elsif Category.all.map{|x|"#{x.format_name}_category"}.include?(method_id.to_s)
      self.class.send :define_method, method_id do
        @category = Category.find_by_format_name(method_id[0..-10])
        @page_title = method_id.to_s.gsub(/\_/, " ").titleize
        @articles = @category.articles
        @other_scenic_spots = Category.all.select{|x|x.scenic_spots==true && x.format_name!=method_id[0..-10]}
        render :template => "index/category", :layout => 'category'
      end
      self.send(method_id)
    else
      super
    end
  end
end
