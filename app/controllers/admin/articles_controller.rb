class Admin::ArticlesController < ApplicationController
  layout "admin"
  before_filter :authenticate_user!

  Category.all.map(&:name).each do |category|
    define_method(category.gsub(/ /, "_").downcase) do
      @category = Category.find_by_name(category)
      render :template => "admin/articles/category", :locals => {:articles => Admin::Article.all }
    end
  end
  
  def tourist_route
    articles = Admin::Article.all.select{|x|x.is_tourist_route==true}
    render :template => "admin/articles/index", :locals => {:articles => articles}
  end

  def scenic_spots
    @categories = Category.all.select{|x|x.scenic_spots==true}    #scenic_spots
    @articles = Admin::Article.all.select{|x|x.is_tourist_route==true}   #tourist_route
    @require_str = ""
    @categories.each do |category|
      if category.id == @categories.first.id
        @require_str += "\'#{category.format_name}=\'+$(\'##{category.format_name}\').val()"
      else
        @require_str += "+\'&#{category.format_name}=\'+$(\'##{category.format_name}\').val()"
      end
    end
    @require_str += "+\"&from=scenic_spots\""
    @require_str = @require_str.html_safe
    render :template => "admin/articles/category"
  end

  # Column Menu
  def category
    @categories = Category.all.select{|x|x.scenic_spots==false}
    @articles = Admin::Article.all.select{|x|x.is_tourist_route==true}

    @require_str = ""
    @categories.each do |category|
      if category.id == @categories.first.id
        @require_str += "\'#{category.format_name}=\'+$(\'##{category.format_name}\').val()"
      else
        @require_str += "+\'&#{category.format_name}=\'+$(\'##{category.format_name}\').val()"
      end
    end
    @require_str += "+\"&from=category\""
    @require_str = @require_str.html_safe
  end

  # GET /admin/articles
  # GET /admin/articles.json  
  def index
    @admin_articles = Admin::Article.all.select{|x|x.is_tourist_route==false}
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_articles }
    end
  end

  # GET /admin/articles/1
  # GET /admin/articles/1.json
  def show
    @admin_article = Admin::Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_article }
    end
  end

  # GET /admin/articles/new
  # GET /admin/articles/new.json
  def new
    @admin_article = Admin::Article.new
    5.times { @admin_article.tour_pictures.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_article }
    end
  end

  # GET /admin/articles/1/edit
  def edit
    @admin_article = Admin::Article.find(params[:id])
    5.times { @admin_article.tour_pictures.build }
  end

  # POST /admin/articles
  # POST /admin/articles.json
  def create
    @admin_article = Admin::Article.new(params[:admin_article])

    respond_to do |format|
      if @admin_article.save
        format.html { redirect_to @admin_article, notice: 'Article was successfully created.' }
        format.json { render json: @admin_article, status: :created, location: @admin_article }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /admin/articles/1
  # PUT /admin/articles/1.json
  def update
    @admin_article = Admin::Article.find(params[:id])
    @admin_article.format_title = @admin_article.title.gsub(/ /,"_").downcase

    respond_to do |format|
      if @admin_article.update_attributes(params[:admin_article])
        format.html { redirect_to @admin_article, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/articles/1
  # DELETE /admin/articles/1.json
  def destroy
    @admin_article = Admin::Article.find(params[:id])
    @admin_article.destroy

    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.json { head :no_content }
    end
  end

  def update_category
    Category.all.each do |category|
      next if params[category.format_name].nil?
      ids = params[category.format_name].split(",")
      if params[:from]=="category"
        category.super_category = params[category.format_name]
        category.save
      else
        Category.find_by_format_name(category.format_name).article_ids = ids 
      end
    end
    render :json => {
      :connect_success => true
    }
  end

  def delete_image
    @tour_picture = TourPicture.find(params[:image_id])
    @tour_picture.image.destroy
    @tour_picture.image.clear
    @tour_picture.delete
    respond_to do |format|
      format.html { redirect_to edit_admin_article_path(params[:id]) }
      format.json { head :no_content }
    end
  end
end